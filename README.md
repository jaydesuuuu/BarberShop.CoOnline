# BARBERSHOP.CO — Setup Guide

## 1. Requirements
- XAMPP (Apache + MySQL + PHP 8+)

## 2. Installation Steps

1. Copy the whole `barbershop.co` folder into `C:\xampp\htdocs\` (or your `htdocs` folder).
2. Start **Apache** and **MySQL** in the XAMPP Control Panel.
3. Open **phpMyAdmin** (`http://localhost/phpmyadmin`).
4. Click the **SQL** tab.
5. Open the file `mysql/schema.sql` from this project, copy ALL of its contents, paste it into the SQL box, and click **Go**.
   - This will create the `barbershop_database` database with all tables and starter data (5 packages, 3 barbers, 1 admin account).
6. Visit `http://localhost/barbershop.co/` in your browser.

**Already have this project installed and just want the newest update?**
See section 7 (Updating an Existing Installation) below instead of re-importing
`schema.sql` from scratch — that would erase your existing data.

## 3. Default Admin Account

- **Phone Number:** `09999999999`
- **Password:** `Admin123!`

Login at `pages/login.php` — since this account's role is Administrator, it will
automatically redirect to the Admin Dashboard (`admin/dashboard.php`).
**Please change this password after logging in (My Profile → Change Password).**

## 4. Folder Structure

```
barbershop.co/
├── admin/                    → Admin dashboard pages (protected, Administrator only)
├── auth/                     → Form processors (login, register, booking, payment, cancel, etc.)
├── db/                       → Database connection
├── includes/                 → Shared header/footer/config/booking-helpers/guards
├── mysql/
│   ├── schema.sql            → Full database schema + seed data (fresh install)
│   ├── migration_v2.sql      → Run if updating from the very first version
│   └── migration_v3.sql      → Run this one if you haven't already (Live Queue columns)
├── pages/                    → Customer-facing pages (login, booking, payment, etc.)
├── scripts/
│   └── live-countdown.js     → Powers the live countdown timers + auto-refresh
├── styles/                   → CSS + images
├── uploads/
│   ├── payment_proofs/       → GCash/PayMaya screenshot uploads
│   └── profile_images/       → Customer profile picture uploads
└── index.php
```

## 5. What's New in This Version

**Bookings now require payment verification before they're "Confirmed"**
Previously, a new booking was immediately marked "Confirmed" even before
paying. That's fixed: every new booking now starts as **Pending**, and only
becomes **Confirmed** once the admin verifies the payment (Cash, GCash, or
PayMaya — whichever the customer chose) under Admin → Payments. The time slot
is still fully protected from double-booking the moment it's created, even
while Pending.

**Customers can cancel their own booking**
A **Cancel Booking** button now appears on "My Bookings" for any booking
that's still Pending, Confirmed, or Waiting. It asks for confirmation first,
and automatically frees up the barber if one was already assigned.

**Cancelled / No Show bookings are now permanently locked**
Once a booking reaches Cancelled or No Show, the admin can no longer change
its status — the dropdown is replaced with a "Final" label. The only way to
get a new appointment after that is to make a brand new booking.

**Cleaner countdown display**
Countdowns that run longer than an hour now show as e.g. `7h 08min : 44sec`
instead of an oddly large raw number like `428:44`.

**Live Queue shows how many more are waiting**
Each barber's "Next Customer" slot now also shows a small note like
"+2 more waiting after" when there's more than one person queued up behind
the immediate next customer.

**Newly added barbers are bookable right away**
Adding a barber under Admin → Barbers now automatically gives them a default
Monday–Saturday, 8:00 AM–7:00 PM schedule, so they show up immediately in the
booking flow instead of being invisible until someone remembers to set up
their schedule separately. (You can still adjust it anytime via "Schedule".)

## 6. Appointment Status Lifecycle (Reference)

```
Pending  →  Confirmed  →  Waiting  →  Completed
   ↓            ↓            ↓
Cancelled    Cancelled    No Show / Cancelled
```

- **Pending** — booked, but payment not yet verified by admin.
- **Confirmed** — payment verified, has a scheduled barber + time, counting
  down to that time on the Live Queue.
- **Waiting** — admin has marked the customer as checked in / their turn has
  come; a 10-minute grace period counts down. If it runs out, the system
  automatically marks it **No Show** and frees the barber.
- **Completed** — admin marks this once the haircut is done. Automatically
  removes it from the Live Queue and frees the barber.
- **Cancelled / No Show** — final. Cannot be changed afterward.

## 7. What's Included From Earlier Updates

- **Type-your-own-time booking** — customers type a preferred time; if it's
  taken, the system suggests the closest open time and asks for confirmation.
- **Choose your barber** — busy barbers are shown but disabled at that time.
- **Age verification for online payments** — GCash/PayMaya require the
  customer to be 18+ (checked both in the page and again on the server);
  otherwise Cash is used automatically, including for the ₱100 reservation fee.
- **One active booking at a time** — a customer can't start a new booking
  while they already have one in progress.
- Business hours enforced (8:00 AM–7:00 PM), holiday calendar, Reservation
  fallback (₱100 fee) when fully booked, GCash/PayMaya/Cash payments with
  proof verification, and the full Admin Dashboard (stats, barbers, services,
  reports, calendar, contact messages).

## 8. Updating an Existing Installation

Do this instead of re-importing `schema.sql` (which would erase your data):

1. Replace all the project files with this new version.
2. Open phpMyAdmin → SQL tab.
3. **If you've never run a migration script before**, run
   `mysql/migration_v2.sql` first, then `mysql/migration_v3.sql`.
   **If you already ran both before**, you don't need to run anything new —
   this update only changed application logic, not the database structure.
4. Note: any appointment created *before* this update that shows as
   "Confirmed" without a verified payment is just old test data from before
   this fix — you can leave it, or manually correct it from Admin →
   Appointments. All *new* bookings from now on will correctly start as
   "Pending" until paid.

## 9. Notes for Your Defense / Demo

- **Payment-gated confirmation demo**: book an appointment as a customer —
  notice it shows "Pending" on My Bookings. Log in as admin, go to Payments,
  verify the payment — switch back to My Bookings and it now shows
  "Confirmed" with a live countdown.
- **Cancel demo**: on My Bookings, click "Cancel Booking" on a Pending/
  Confirmed booking, confirm the prompt, and see it move to "Cancelled" —
  try changing its status from the admin side afterward and you'll see it's
  locked as "Final".
- **Live Queue demo**: assign a barber to a booking (or verify its payment),
  then open the homepage in another tab — you'll see the live countdown
  ticking down. Set it to "Waiting" to see the 10-minute grace-period
  countdown start instead.
- **Auto no-show demo**: set a booking to "Waiting", then (for a faster demo)
  temporarily edit `WAITING_GRACE_PERIOD_MINUTES` in
  `includes/booking_helpers.php` to a smaller number like `1`, reload the
  homepage after that time passes, and watch it flip to "No Show" and free
  the barber automatically. (Remember to change it back to `10` afterward.)
- To simulate a fully-booked day, book several appointments back-to-back for
  one barber, then try booking again at the same time — you'll see the
  automatic Reservation fallback.
- To test the holiday feature, add today's date under Admin → Calendar, then
  try to book — the booking page will show "The Shop Is Closed That Day".
- To test the age restriction, register a test account with a birthdate less
  than 18 years ago, then try to pay — GCash/PayMaya will be disabled.
#   B a r b e r S h o p . C o O n l i n e  
 
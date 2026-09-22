<?php

if (session_status() === PHP_SESSION_NONE) {

    session_start();

}


// =====================================================
// $baseWebsitePath MUST be set by the page that includes
// this header BEFORE including it.
//   - index.php (root)        -> ""
//   - pages/xxx.php           -> "../"
//   - admin/xxx.php           -> "../"
// =====================================================

$baseWebsitePath = $baseWebsitePath ?? "";


$isCustomerLoggedIn =
    isset($_SESSION["customer_logged_in"]) &&
    $_SESSION["customer_logged_in"] === true;


$isAdministrator =
    $isCustomerLoggedIn &&
    ($_SESSION["customer_role"] ?? "") === "Administrator";


$currentCustomerName =
    $_SESSION["customer_name"] ?? "";


$currentCustomerProfileImage =
    $baseWebsitePath . "styles/images/logo_for_about.jpg";

?>

<!-- =====================================================
     MAIN NAVIGATION
     ===================================================== -->

<nav class="navbar navbar-expand-lg main-navbar">

    <div class="container">


        <!-- LOGO -->

        <a
            class="navbar-brand brand-logo"
            href="<?php echo $baseWebsitePath; ?>index.php"
        >

            <span class="brand-icon">
                <i class="bi bi-scissors"></i>
            </span>

            <span>
                BARBERSHOP<span class="brand-dot">.CO</span>
            </span>

        </a>


        <!-- MOBILE MENU BUTTON -->

        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#mainNavigation"
            aria-controls="mainNavigation"
            aria-expanded="false"
            aria-label="Toggle navigation"
        >

            <span class="navbar-toggler-icon"></span>

        </button>


        <!-- NAVIGATION -->

        <div class="collapse navbar-collapse" id="mainNavigation">

            <ul class="navbar-nav mx-auto">

                <li class="nav-item">
                    <a class="nav-link" href="<?php echo $baseWebsitePath; ?>index.php">
                        HOME
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<?php echo $baseWebsitePath; ?>pages/about.php">
                        ABOUT
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<?php echo $baseWebsitePath; ?>index.php#services">
                        SERVICES
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<?php echo $baseWebsitePath; ?>pages/contact.php">
                        CONTACT
                    </a>
                </li>

                <?php if ($isCustomerLoggedIn && !$isAdministrator): ?>

                <li class="nav-item">
                    <a class="nav-link" href="<?php echo $baseWebsitePath; ?>pages/my_bookings.php">
                        MY BOOKINGS
                    </a>
                </li>

                <?php endif; ?>

            </ul>


            <!-- =====================================================
                 AUTHENTICATION / CUSTOMER AREA
                 ===================================================== -->

            <div class="customer-navigation-area">


                <?php if (!$isCustomerLoggedIn): ?>

                    <div class="authentication-navigation-buttons">

                        <a href="<?php echo $baseWebsitePath; ?>pages/login.php" class="navigation-login-button">
                            LOGIN
                        </a>

                        <a href="<?php echo $baseWebsitePath; ?>pages/register.php" class="navigation-register-button">
                            REGISTER
                        </a>

                    </div>

                <?php else: ?>

                    <div class="customer-profile-wrapper">

                        <button
                            type="button"
                            class="customer-profile-area"
                            onclick="toggleCustomerProfileMenu()"
                        >

                            <img
                                src="<?php echo htmlspecialchars($currentCustomerProfileImage); ?>"
                                alt="Customer profile"
                                class="profile-image"
                            >

                            <div class="profile-information">

                                <span class="profile-label">
                                    <?php echo $isAdministrator ? "ADMIN" : "PROFILE"; ?>
                                </span>

                                <span class="profile-name">
                                    <?php echo htmlspecialchars($currentCustomerName); ?>
                                </span>

                            </div>

                            <i class="bi bi-chevron-down profile-arrow"></i>

                        </button>


                        <div class="customer-profile-dropdown" id="customerProfileDropdown">

                            <div class="customer-dropdown-name">
                                <span>Signed in as</span>
                                <strong><?php echo htmlspecialchars($currentCustomerName); ?></strong>
                            </div>

                            <div class="customer-dropdown-divider"></div>

                            <?php if ($isAdministrator): ?>

                                <a href="<?php echo $baseWebsitePath; ?>admin/dashboard.php" class="customer-logout-button">
                                    <i class="bi bi-speedometer2"></i>
                                    <span>ADMIN DASHBOARD</span>
                                </a>

                            <?php else: ?>

                                <a href="<?php echo $baseWebsitePath; ?>pages/my_bookings.php" class="customer-logout-button">
                                    <i class="bi bi-calendar-check"></i>
                                    <span>MY BOOKINGS</span>
                                </a>

                                <a href="<?php echo $baseWebsitePath; ?>pages/profile.php" class="customer-logout-button">
                                    <i class="bi bi-person"></i>
                                    <span>MY PROFILE</span>
                                </a>

                            <?php endif; ?>

                            <a href="<?php echo $baseWebsitePath; ?>auth/logout.php" class="customer-logout-button">
                                <i class="bi bi-box-arrow-right"></i>
                                <span>LOGOUT</span>
                            </a>

                        </div>

                    </div>

                <?php endif; ?>

            </div>

        </div>

    </div>

</nav>

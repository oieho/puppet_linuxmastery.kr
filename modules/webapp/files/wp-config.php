<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'masterblog' );

/** Database username */
define( 'DB_USER', 'master' );

/** Database password */
define( 'DB_PASSWORD', 'ppassword' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '|Nv[>x,)53`pmY:dO9Ko=,lSiT+$}jVa<pTfU{Z=?h6dm;Bm,<t1ZHM|2qvA/dF8' );
define( 'SECURE_AUTH_KEY',  'pr%`#Blhf9t5q{Q7O3EXS})vf@NE|Q:IR?9A.BVd-eMPK~WR)%;0. q%x/YQW6:p' );
define( 'LOGGED_IN_KEY',    'NLhAT9JF9NILhcv3 {O|LH3 1GZ1dk8MKcevCuW^QRKCs_Fna/[O4Fq|!+i>!XFI' );
define( 'NONCE_KEY',        '[r[~_)iQ,S9kU+lH`aKP_U|GT<NkAq[BP6bok%Qp$*O<G6b|2~z#Tbb<WypA,}x{' );
define( 'AUTH_SALT',        'R_i[tX|#0S^<5;5jfHm>meV:u@8AhB)>(^/G:l7 ]%d?hSmVb!MUA%,D~[_$FVP ' );
define( 'SECURE_AUTH_SALT', 'QlG2GGkh@CEQzL8D.$XUy5-h|_?zVfY5`EwtuaV%/U@ByT0mO]lXbn>tbSlrgiz:' );
define( 'LOGGED_IN_SALT',   '^3TJ:W:j^9xeUR4eAee>dXNs/ z3!s4$!K,D2Tpb{ml#/YZaO*Wwfq;zv)f{>CIz' );
define( 'NONCE_SALT',       '<qyy&8Jx g< t(LhTui.zXgP5OibI<o/Y(]FE<MZ|cQX1S<FiT^wL]R0p,YlL$o&' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

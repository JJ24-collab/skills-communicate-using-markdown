<?php
/**
 * WordPress Shortcode dla Mapy Ambasadorów
 *
 * Instrukcja:
 * 1. Skopiuj cały ten kod
 * 2. Wklej w Appearance → Theme Editor → functions.php (na końcu pliku)
 * 3. Zapisz
 * 4. W artykule użyj: [mapa_ambasadorow]
 *
 * Przykłady użycia:
 * [mapa_ambasadorow]
 * [mapa_ambasadorow height="600px"]
 * [mapa_ambasadorow height="700px" width="90%"]
 */

function ambassador_map_shortcode($atts) {
    // Domyślne parametry
    $atts = shortcode_atts(array(
        'height' => '800px',
        'width' => '100%',
        'url' => '/ambassador-map/ambassador-map.html' // Zmień na swoją ścieżkę
    ), $atts);

    // Sanityzacja
    $height = esc_attr($atts['height']);
    $width = esc_attr($atts['width']);
    $url = esc_url($atts['url']);

    // Generuj HTML
    $output = '<div class="ambassador-map-container" style="margin: 2rem 0;">';
    $output .= '<iframe';
    $output .= ' src="' . $url . '"';
    $output .= ' width="' . $width . '"';
    $output .= ' height="' . $height . '"';
    $output .= ' frameborder="0"';
    $output .= ' style="border: none; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);"';
    $output .= ' loading="lazy"';
    $output .= ' title="Mapa ambasadorów Rzeczypospolitej Polskiej"';
    $output .= ' allowfullscreen>';
    $output .= '</iframe>';
    $output .= '</div>';

    // Dodaj CSS dla responsywności
    $output .= '<style>
        .ambassador-map-container iframe {
            max-width: 100%;
        }
        @media (max-width: 768px) {
            .ambassador-map-container iframe {
                height: 500px !important;
            }
        }
        @media (max-width: 480px) {
            .ambassador-map-container iframe {
                height: 400px !important;
            }
        }
    </style>';

    return $output;
}
add_shortcode('mapa_ambasadorow', 'ambassador_map_shortcode');

/**
 * Opcjonalnie: Dodaj blok Gutenberg
 * Wymaga: WordPress 5.0+
 */
function register_ambassador_map_block() {
    if (!function_exists('register_block_type')) {
        return;
    }

    wp_register_script(
        'ambassador-map-block',
        get_template_directory_uri() . '/js/ambassador-map-block.js',
        array('wp-blocks', 'wp-element', 'wp-editor'),
        filemtime(get_template_directory() . '/js/ambassador-map-block.js')
    );

    register_block_type('custom/ambassador-map', array(
        'editor_script' => 'ambassador-map-block',
        'render_callback' => 'ambassador_map_shortcode',
        'attributes' => array(
            'height' => array(
                'type' => 'string',
                'default' => '800px'
            ),
            'width' => array(
                'type' => 'string',
                'default' => '100%'
            )
        )
    ));
}
add_action('init', 'register_ambassador_map_block');

/**
 * Dodaj przycisk do klasycznego edytora (opcjonalne)
 */
function ambassador_map_add_tinymce_button() {
    global $typenow;

    // Sprawdź typ postu
    if (!current_user_can('edit_posts') && !current_user_can('edit_pages')) {
        return;
    }

    // Sprawdź czy rich editing jest włączone
    if (get_user_option('rich_editing') !== 'true') {
        return;
    }

    add_filter('mce_external_plugins', 'ambassador_map_add_tinymce_plugin');
    add_filter('mce_buttons', 'ambassador_map_register_button');
}
add_action('admin_head', 'ambassador_map_add_tinymce_button');

function ambassador_map_add_tinymce_plugin($plugin_array) {
    $plugin_array['ambassador_map_button'] = get_template_directory_uri() . '/js/ambassador-map-tinymce.js';
    return $plugin_array;
}

function ambassador_map_register_button($buttons) {
    array_push($buttons, 'ambassador_map_button');
    return $buttons;
}

/**
 * Dodaj Quick Tag (dla edytora HTML)
 */
function ambassador_map_quicktag() {
    if (wp_script_is('quicktags')) {
        ?>
        <script type="text/javascript">
        QTags.addButton('ambassador_map', 'Mapa Ambasadorów', '[mapa_ambasadorow]', '', '', 'Wstaw mapę ambasadorów');
        </script>
        <?php
    }
}
add_action('admin_print_footer_scripts', 'ambassador_map_quicktag');

/**
 * Dodaj help/dokumentację w admin panel
 */
function ambassador_map_admin_notice() {
    $screen = get_current_screen();
    if ($screen->base !== 'post' && $screen->base !== 'page') {
        return;
    }
    ?>
    <div class="notice notice-info is-dismissible" style="display:none;" id="ambassador-map-help">
        <p><strong>Mapa Ambasadorów:</strong> Użyj shortcode <code>[mapa_ambasadorow]</code> aby osadzić mapę w treści.</p>
        <p>Parametry opcjonalne: <code>height="600px" width="90%"</code></p>
    </div>
    <script>
    jQuery(document).ready(function($) {
        // Pokaż pomoc tylko raz na sesję
        if (!sessionStorage.getItem('ambassador_map_help_shown')) {
            $('#ambassador-map-help').show();
            sessionStorage.setItem('ambassador_map_help_shown', '1');
        }
    });
    </script>
    <?php
}
add_action('admin_notices', 'ambassador_map_admin_notice');

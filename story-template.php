<?php
/*
 * Template Name: Custom Blog Post
 * Description: A custom template for individual blog posts in WordPress.
 */
get_header(); // This includes your theme's header.php
if (have_posts()) : while (have_posts()) : the_post();
// Define variables for extra fields (if not standard WP fields, you'll need Advanced Custom Fields plugin or similar)
$author_twitter_handle = get_field('author_twitter_handle'); // Example of using ACF for custom fields
$page_image_url = get_field('page_image_url');
$page_image_caption = get_field('page_image_caption');
$social_media_large_image = get_field('social_media_large_image');
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php wp_title(''); ?></title>
    <meta name="description" content="<?php echo get_the_excerpt(); ?>">

    <!-- Open Graph / Facebook -->  
    <meta property="og:type" content="article" />
    <meta property="og:url" content="<?php echo get_permalink(); ?>" />
    <meta property="og:title" content="<?php echo get_the_title(); ?>" />
    <meta property="og:description" content="<?php echo get_the_excerpt(); ?>" />
    <meta property="og:image" content="<?php echo $social_media_large_image; ?>" />

    <!-- Twitter -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:site" content="<?php echo $author_twitter_handle; ?>">
    <meta name="twitter:title" content="<?php echo get_the_title(); ?>">
    <meta name="twitter:description" content="<?php echo get_the_excerpt(); ?>">
    <meta name="twitter:image" content="<?php echo $social_media_large_image; ?>">

    <!-- Schema.org Markup -->
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "BlogPosting",
        "headline": "<?php echo get_the_title(); ?>",
        "image": [
            "<?php echo $page_image_url; ?>"
        ],
        "author": {
            "@type": "Person",
            "name": "<?php the_author(); ?>",
            "url": "<?php echo $author_url; ?>"
        },
        "publisher": {
            "@type": "Organization",
            "name": "<?php bloginfo('name'); ?>",
            "logo": {
                "@type": "ImageObject",
                "url": "<?php echo $publisher_logo_url; ?>"
            }
        },
        "datePublished": "<?php echo get_the_date('c'); ?>",
        "dateModified": "<?php the_modified_date('c'); ?>",
        "description": "<?php echo get_the_excerpt(); ?>"
    }
    </script>

    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
    <header>
        <!-- Navigation and site-wide header content can go here -->
    </header>

    <main>
        <article>
            <header>
                <!-- Article-specific header content -->
                <h1><?php the_title(); ?></h1>
                <p class="byline">By <a href="<?php echo $author_url; ?>" target="_blank" rel="author noopener noreferrer"><?php the_author(); ?></a> | <time datetime="<?php echo get_the_date('c'); ?>"><?php the_date(); ?></time></p>
            </header>

            <figure>
                <img src="<?php echo $page_image_url; ?>" alt="<?php echo $page_image_caption; ?>">
                <figcaption><?php echo $page_image_caption; ?></figcaption>
            </figure>

            <section class="article-body">
                <?php the_content(); ?>
            </section>
        </article>
    </main>

    <footer>
        <nav>
            <ul>
                <li><a href="<?php echo home_url(); ?>">Home</a></li>
                <li><a href="<?php echo home_url('/privacy-policy'); ?>">Privacy Policy</a></li>
                <li><a href="<?php echo home_url('/terms-of-use'); ?>">Terms of Use</a></li>
            </ul>
        </nav>
        <p>&copy; <?php 
            $startYear = 2022; // The year you started the website or want the copyright notice to start from
            $currentYear = date('Y'); // Current year
            if ($startYear == $currentYear) {
                echo $startYear;
            } else {
                echo "{$startYear}–{$currentYear}";
            }
        ?> <a href="<?php bloginfo('url'); ?>"><?php bloginfo('name'); ?></a>. All rights reserved.</p>
    </footer>

    <?php wp_footer(); ?>
</body>
</html>

<?php
endwhile; endif;
get_footer(); // This includes your theme's footer.php
?>

# Imports an xml dump into the wiki.
#
#  $xml_dump should be the /fully/qualified/path to a dump
#
#  $dump_sentinel_page should specify a page unique to the dump.  As long as
#   $dump_sentinel_page is not present in the wiki we will keep trying the import.
#
# We try to do this only on the first run and not clobber existing imports.
#
define mediawiki::import_dump(
    $xml_dump,
    $dump_sentinel_page,
) {
    include mediawiki

    exec { 'import_dump':
        require   => Class['mediawiki'],
        command   => "php5 ${mediawiki::dir}/maintenance/importDump.php ${xml_dump}",
        unless    => "php5 ${mediawiki::dir}/maintenance/pageExists.php ${dump_sentinel_page}",
        user      => 'www-data',
    }
}

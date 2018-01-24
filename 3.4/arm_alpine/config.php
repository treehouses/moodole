<?php  // Moodle configuration file
unset($CFG);
global $CFG;
$CFG = new stdClass();
$CFG->dbtype    = 'pgsql';
$CFG->dblibrary = 'native';
$CFG->dbhost    = getenv('MOODOLE_DB_URL');
$CFG->dbname    = getenv('MOODOLE_DB_NAME');
$CFG->dbuser    = getenv('MOODOLE_DB_USER');
$CFG->dbpass    = getenv('MOODOLE_DB_PASS');
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => getenv('MOODOLE_DB_PORT'),
  'dbsocket' => '',
);
// $CFG->wwwroot   = getenv('MOODOLE_URL');;
$CFG->wwwroot   = 'http://'.$_SERVER['HTTP_HOST'];
$CFG->dataroot  = '/var/lib/nginx/moodledata';
$CFG->admin     = 'admin';
$CFG->directorypermissions = 0777;
require_once(__DIR__ . '/lib/setup.php');
// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
<?PHP
unset($CFG);  
global $CFG;  // This is necessary here for PHPUnit execution
$CFG = new stdClass();
$CFG->dbtype    = 'mysqli';      
$CFG->dblibrary = 'native';     
$CFG->dbhost    = getenv('DB_PORT_3306_TCP_ADDR');  
$CFG->dbname    = getenv('DB_ENV_MYSQL_DATABASE');
$CFG->dbuser    = getenv('DB_ENV_MYSQL_USER');
$CFG->dbpass    = getenv('DB_ENV_MYSQL_PASSWORD');
$CFG->prefix    = 'mdl_';       // prefix to use for all table names
$CFG->dboptions = array(
    'dbpersist' => false,
    'dbsocket'  => false,
    'dbport'    => getenv('DB_PORT_3306_TCP_PORT'),
);
$CFG->wwwroot   = getenv('MOODLE_URL');
$CFG->dataroot  = '/moodle/moodledata';
$CFG->directorypermissions = 02777;
$CFG->admin = 'admin';
$CFG->noemailever = true;    // NOT FOR PRODUCTION SERVERS!
require_once(dirname(__FILE__) . '/lib/setup.php'); // Do not edit

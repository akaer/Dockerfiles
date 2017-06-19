<?php

$tlCfg->config_check_warning_mode = 'SILENT';
$tlCfg->document_generator->company_name = '@@COMPANYNAME@@';
$tlCfg->user_self_signup = FALSE;

$g_smtp_host = '@@SMTPRELAY@@';
$g_tl_admin_email = '@@ADMINEMAIL@@';
$g_from_email = '@@DEFAULTSENDERADDRESS@@';
$g_return_path_email = '@@DEFAULTSENDERADDRESS@@';

$tlCfg->authentication['method'] = 'LDAP';
$tlCfg->authentication['ldap'][1]['ldap_server'] = '10.10.206.206';
$tlCfg->authentication['ldap'][1]['ldap_port'] = '389';
$tlCfg->authentication['ldap'][1]['ldap_version'] = '3';
$tlCfg->authentication['ldap'][1]['ldap_root_dn'] = 'dc=vi,dc=lan';
$tlCfg->authentication['ldap'][1]['ldap_tls'] = false;
$tlCfg->authentication['ldap'][1]['ldap_uid_field'] = 'sAMAccountName';

$tlCfg->authentication['ldap_automatic_user_creation'] = true;

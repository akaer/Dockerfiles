<?php

$tlCfg->config_check_warning_mode = 'SILENT';
$tlCfg->document_generator->company_name = '@@COMPANYNAME@@';
$tlCfg->user_self_signup = FALSE;

$g_smtp_host = '@@SMTPRELAY@@';
$g_tl_admin_email = '@@ADMINEMAIL@@';
$g_from_email = '@@DEFAULTSENDERADDRESS@@';
$g_return_path_email = '@@DEFAULTSENDERADDRESS@@';

$tlCfg->default_roleid = TL_ROLES_ADMIN;


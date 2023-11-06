class webapp {

   include webapp::web
   include webapp::db
   include webapp::wp

   Class['webapp::db'] -> Class['webapp::wp']
}

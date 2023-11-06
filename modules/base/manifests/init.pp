class base {
   include base::install
   include base::vim
   include base::ssh

   class { 'apt':
      update => {
         frequency => 'daily',
      },
   }

   notify { "===== base =====\n": }
}

node 'vm01.linuxmastery.kr' {
   include base
   include webapp
}

node 'vm02.linuxmastery.kr' {
   include base
   include webapp
}

node 'vm03.linuxmastery.kr' {
   include base
   include fortunecow
}

node default {
   notify { 'default_message':
      message => "===== default =====\n",
   }
}

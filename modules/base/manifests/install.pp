class base::install {
   package { ['tree', 'curl', 'wget', 'unzip']: }
   notify { "===== base::install =====\n": }
}

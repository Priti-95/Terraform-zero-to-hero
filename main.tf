# Simple file Automation with code

# block parameters {
#       arguments
# }

resource "local_file" "my_file" {

  filename        = "demo-automated.txt"
  content         = "hello dosto"
  file_permission = "664"

}

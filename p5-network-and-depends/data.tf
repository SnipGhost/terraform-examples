# Используем data-ресурс для поиска образа по имени
data "vkcs_images_image" "debian" {
  name = "debian-13-202602051630.gite7a38aaf"
}

# Используем data-ресурс для поиска шаблона ресурсов по имени
data "vkcs_compute_flavor" "minimal" {
  name = "STD2-1-1"
}

# Используем data-ресурс для поиска secgorup по имени
data "vkcs_networking_secgroup" "ssh" {
  name = "ssh"
}

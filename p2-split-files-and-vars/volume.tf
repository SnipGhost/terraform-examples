# Создаем root volume
resource "vkcs_blockstorage_volume" "test_volume" {
  name              = "test-volume"
  availability_zone = var.availability_zone
  volume_type       = var.volume_type
  size              = var.disk_size
  image_id          = data.vkcs_images_image.debian.id
}

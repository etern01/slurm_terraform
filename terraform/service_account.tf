resource "yandex_iam_service_account" "sa" {
  name        = "sa"
  description = "service account to manage VMs"
  folder_id   = var.folder_id

}
resource "yandex_resourcemanager_folder_iam_binding" "admin" {
  folder_id = var.folder_id

  role = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}


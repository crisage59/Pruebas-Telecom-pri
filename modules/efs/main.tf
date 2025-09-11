resource "aws_efs_access_point" "this" {
  file_system_id = var.efs_id
  posix_user {
    gid            = "1000"
    secondary_gids = [1003, 1002]
    uid            = "1000"
  }
  root_directory {
    path = "/${var.tags.Module}/${var.tags.Site}"
    creation_info {
      owner_gid   = "1000"
      owner_uid   = "1000"
      permissions = "0755"
    }
  }
  tags = var.tags
}
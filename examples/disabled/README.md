# Example: Disabled by enabled variable

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment |  | string | `"dev"` | no |
| organization |  | string | `"testorg"` | no |
| region |  | string | `"us-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arns | List of AWS S3 Bucket ARNs |
| domain\_names | List of AWS S3 Bucket Domain Names |
| hosted\_zone\_ids | List of AWS S3 Bucket Hosted Zone IDs |
| ids | List of AWS S3 Bucket IDs |
| name\_bases | List of base names used to generate S3 bucket names |
| names | List of AWS S3 Bucket Names |
| regions | List of AWS S3 Bucket Regions |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# tg_aws_terraform_state

## Example common.hcl

```
inputs = {
  profile     = "default"
  region      = "us-east-2"
  bucket_name = "bla-bla-bla"
  lock_table  = "bla-bla-bla-table"
  tags = {
    ENV = "bla-bla-bla"
  }
}
```
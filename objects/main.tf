variable public_bucket {}
variable private_bucket {}
variable lambda_json_zip_path {}

provider "aws" {
  alias = "lambda_edge"
}
resource "aws_s3_bucket_object" "example_image" {
  bucket       = "${var.public_bucket}"
  key          = "example.jpg"
  source       = "src/assets/example.jpg"
  acl          = "public-read"
  content_type = "image/jpeg"

  etag = "${filemd5("src/assets/example.jpg")}"
}

resource "aws_s3_bucket_object" "lambda_json" {
  bucket       = "${var.private_bucket}"
  key          = "lambda-json-archive.zip"
  source       = "${var.lambda_json_zip_path}"
  content_type = "application/zip"

  etag = "${filemd5(var.lambda_json_zip_path)}"
}


# OUTPUTS
output "example_image_key" {
  value = "${aws_s3_bucket_object.example_image.id}"
}


output "lambda_json_key" {
  value = "${aws_s3_bucket_object.lambda_json.key}"
}

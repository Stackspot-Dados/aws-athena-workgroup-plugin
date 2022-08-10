resource "aws_athena_workgroup" "workgroup_{{inputs.workgroup_name}}" {
    name        = "{{inputs.workgroup_name}}"
    configuration {
        enforce_workgroup_configuration     = false
        publish_cloudwatch_metrics_enabled  = true
        bytes_scanned_cutoff_per_query      = {{bytes_scanned}}

        result_configuration {
            output_location     = "s3://{{inputs.bucket_name}}/"

            encryption_configuration {
                encryption_option     = "{{inputs.encryption_option}}"
                {% if inputs.encryption_option == 'CSE_KMS' or inputs.encryption_option == 'SSE_KMS' %}
                kms_key_arn           = "{{inputs.kms_key_arn}}"
                {% endif %}
            }
        }
    }
}
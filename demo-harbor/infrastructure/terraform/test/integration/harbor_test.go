package test

import (
    "fmt"
	"testing"
	//"time"
	"github.com/gruntwork-io/terratest/modules/http-helper"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestHarborServer(t *testing.T) {
	t.Parallel()

	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../",
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	dns := terraform.Output(t, terraformOptions, "DNS")
	
	url := fmt.Sprintf("http://%s", dns)


	statusCode, body := http_helper.HttpGet(t,  url, nil)
	fmt.Sprintf("Bosy : %s", body)
	assert.Equal(t, 200, statusCode)
}

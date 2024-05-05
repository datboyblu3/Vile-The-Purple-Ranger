######################################################################################
# Store DO API Token in environment variable
# Step 1: export DO_PAT="API_TOKEN"
# Step 2: terraform plan -var "do_token=${DO_PAT}"
# Step 3: terraform apply -auto-approve -var "do_token=${DO_PAT}"
# Step 4: terraform destroy -auto-approve -var "do_token=${DO_PAT}”
######################################################################################

resource "digitalocean_tag" "purple_team_project" {
  name = "purple_team_project"
}
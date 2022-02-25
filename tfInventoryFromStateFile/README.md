## Problem

I have a lot of aws resources created using Terraform in my AWS account. The TF code potentially pulls in lot of third party repositories as well as TF modules within the corporate environment of which not all are accessible on my laptop everytime. 
I can visualize those resources using many tools available. Many tools exist for visualizing TF created resources, as well as visualizing a tf plan.
But how do I simply get an inventory of all the resources deployed by Terraform?
 - I want to just get a CVS/Excel export
 - I need a list of all AWS resources that my Terraform code has provisioned - with the logical name in TF, the ARN, the ID of the resource etc
 - It has to be simple file format like CSV.

## Why not just use tf state list?

Because - tf state list works well when your TF code is simple - and not pulling tons of third party modules.
Third party modules may not be available to be downloaded (Imagine a corporate env where only Jenkins can pull the third party modules - from say enterprise github repos)
From your local machine you can't download these modules if your TF code runs in a Jenkins pipeline, and your may not have access to all third party modules. So tf state list has trouble getting those modules.

## So what is my solution?
 - Download the state file from the S3 bucket (DevOps teams usually have access to the state file)
 - Parse the state file to extract information needed (`jq` to the rescue)
 - Put the required data in a simple plain CSV file.

## A bit about the implementation
 - It is a simple bash script
 - It needs bash version 4.0 or higher (expects readarray to be present)
 - It needs jq utility to be present.
 - You need to have the state file downloaded on your local machine.
 - Just pass in the path to the state file, and you will get back a simple CSV with details of resource type, name in TF code, ARN and ID.



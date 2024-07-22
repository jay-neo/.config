function getInstanceId {
    Param (
        [string]$InstanceName
    )

    if ($InstanceName -eq '') {
        $InstanceName = Read-Host "Enter your instance name"
    }
    $InstanceID = aws ec2 describe-instances --filters "Name=tag:Name,Values=$InstanceName" --query "Reservations[0].Instances[0].InstanceId" --output text
    return $InstanceID
}

function launchInstance {
    $InstanceName = Read-Host ">> Instance Name"
    if ($InstanceName -eq '') {
        $InstanceName = (Get-Date).tostring("jay-neo_dd-MM-yyyy_HH:mm:ss")
    }

    $InstanceID = Read-Host ">> OS Image Name"
    switch ($InstanceID.ToLower()) {
        "" { $InstanceID = "ami-007020fd9c84e18c7" }
        "ubuntu" { $InstanceID = "ami-007020fd9c84e18c7" }
        "debain" { $InstanceID = "ami-0850beb48a8b4bb46" }
        "redhat" { $InstanceID = "ami-05a5bb48beb785bf1" }
        "amazon" { $InstanceID = "ami-001843b876406202a" }
        "windows" { $InstanceID = "ami-07ef4004db979fcd4"}
        default {
            Write-Error "$InstanceID Image ID not found" -f Red
            $InstanceID = Read-Host ">> Provide Valid OS Image ID"
        }
    }

    $SSHKeyName = Read-Host ">> SSH Key Pair Name"
    while ($SSHKeyName -eq '') {
        $SSHKeyName = Read-Host ">> SSH Key Pair Name"
    }

    $SecurityGroupName = Read-Host ">> Security Group Name"
    while ($SecurityGroupName -eq '') {
        $SecurityGroupName = Read-Host ">> Security Group Name"
    }

    $cmd = "aws ec2 run-instances --image-id $InstanceID --count 1 --instance-type t2.micro --key-name $SSHKeyName --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$InstanceName}]' --security-groups $SecurityGroupName"

    $UserDataFile = Read-Host ">> User Data"
    if ($UserDataFile -ne '') {
        $cmd += " --user-data 'curl -L https://raw.githubusercontent.com/jay-neo/aws/master/$UserDataFile.sh | bash'"
    }

    return $cmd
}

function ec2 {
    param (
        [Parameter(Position = 0)]
        [string]$query,
        [Parameter(Position = 1)]
        [string]$secondQuery
    )
    if ($query -eq '') {
        aws ec2 describe-instances --query 'Reservations[*].Instances[*].{InstanceName:Tags[?Key==`Name`].Value | [0], InstanceID:InstanceId, State:State.Name, PublicIP:PublicIpAddress, SSHKeyName:KeyName, SecurityGroup:SecurityGroups[0].GroupId, SubnetId:SubnetId}'
    } elseif ($query -eq 'launch') {
        $cmd = launchInstance
        Invoke-Expression $cmd
    } elseif ($query -eq 'start') {
        $InstanceID = getInstanceId $secondQuery
        aws ec2 start-instances --instance-ids $InstanceID
    } elseif ($query -eq 'stop') {
        $InstanceID = getInstanceId $secondQuery
        aws ec2 stop-instances --instance-ids $InstanceID
    } elseif ($query -eq 'terminate') {
        $InstanceID = getInstanceId $secondQuery
        aws ec2 terminate-instances --instance-ids $InstanceID
    } elseif ($query -eq 'volume') {
        aws ec2 describe-volumes --query 'Volumes[*].{ID:VolumeId,InstanceId:Attachments[0].InstanceId,AZ:AvailabilityZone,Size:Size}'
    }

}
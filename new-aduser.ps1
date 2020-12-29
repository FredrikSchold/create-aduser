$usercsv ="C:\Temp\ad-user.csv"
#Titta om det finns en fil om inte stäng script
If (Test-Path $usercsv) {

    Import-Module ActiveDirectory
    add-type -AssemblyName System.web #används för lösenordsgenerering
    $ADusers = Import-Csv  $usercsv -Delimiter ';' -Encoding UTF8
    $newusertxt =  "C:\Script\New User\CreatedUser\aduser.txt"

    foreach ($user in $ADusers) {

        $firstname =$user.firstname
        $lastname = $user.lastname
        $telephone = $user.telephone
        $title = $user.jobTitle
        $OU = 'OU=Kontor,OU=users,OU=OUnamn,DC=foretag,DC=se'
        $city = "Landskrona"
        $UPN = "upn.se"
        $username = $firstname + $lastname.Substring(0, [Math]::Min($lastname.Length, 2)) #Genererar ett username med förnamn och 2 första i efternamn
        $Password = "Hello" + ([System.Web.Security.Membership]::GeneratePassword(8,3)) #Genererar ett lösenord där första siffran är hur många tecken utöver "Hello" och andra siffran är antal icke alfabetiska karaktärer
        $email = $firstname + "." + $lastname + "@" + $UPN
        Write-Host $firstname $lastname "Skapas nu i AD med användarnamn:" $username "och mejladress: " $email "och pw: " $Password

        If (Get-Aduser -F {SamAccountName -eq $username}){
            #Om användaren finns släng felmeddelande
            Write-Warning "En användare med det användarnamnet finns redan "

        }
        else  {

            #Användaren finns inte och vi kan fortsätta skapa konto
            New-ADUser `
                -SamAccountName $username `
                -UserPrincipalName "$username@$UPN" `
                -Name "$firstname $lastname" `
                -GivenName $firstname `
                -Surname $lastname `
                -Enabled $True `
                -DisplayName "$firstname $lastname" `
                -Path $OU `
                -City $city `
                -OfficePhone $telephone `
                -EmailAddress $email `
                -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True #Tänk på att ALLTID använda ConvertTo-secureString så att man inte kan använda Get-history för att se gamla ps-körningars pw

            # Om användaren är skapad skriv meddelande.
            Write-Host "Kontot $username är skapat!" -ForegroundColor Cyan

            New-Item $newusertxt
            Add-Content $newusertxt "Användare: $firstname $lastname Mejladress: $email  Användarnamn: $username  Lösenord: $password" -Encoding UTF8
   
        }
    }
}

else {
    exit
}$usercsv ="C:\Temp\ad-user.csv"
#Titta om det finns en fil om inte stäng script
If (Test-Path $usercsv) {

    Import-Module ActiveDirectory
    add-type -AssemblyName System.web
    $ADusers = Import-Csv  $usercsv -Delimiter ';' -Encoding UTF8
    $newusertxt =  "C:\Script\New User\CreatedUser\aduser.txt"$newusertxt =  "C:\Script\New User\CreatedUser\aduser.txt"
#Titta om det finns en fil om inte stäng script
If (Test-Path $newusertxt) {

    Import-Module ActiveDirectory
    add-type -AssemblyName System.web #används för att skapa ett randomgenereat lösenord
    $ADusers = Import-Csv C:\Temp\ad-user.csv -Delimiter ';' -Encoding UTF8

    foreach ($user in $ADusers) {

        $firstname =$user.firstname
        $lastname = $user.lastname
        $telephone = $user.telephone
        $title = $user.jobTitle
        $boss = $user.chef
        $OU = 'OU=Kontor,OU=users,OU=OUnamn,DC=foretag,DC=se'
        $city = "Helsingborg"
        $UPN = "upn.se"
        $username = $firstname + $lastname.Substring(0, [Math]::Min($lastname.Length, 2)) #Genererar ett username med förnamn och 2 första i efternamn
        $Password = "Hello" + ([System.Web.Security.Membership]::GeneratePassword(8,3)) #Genererar ett lösenord där första siffran är hur många tecken utöver "Hello" och andra siffran är antal icke alfabetiska karaktärer
        $email = $firstname + "." + $lastname + "@" + $UPN
        Write-Host $firstname $lastname "Skapas nu i AD med användarnamn:" $username "och mejladress: " $email "och pw: " $Password

        If (Get-Aduser -F {SamAccountName -eq $username}){
            #Om användaren finns släng felmeddelande
            Write-Warning "En användare med det användarnamnet finns redan "

        }
        else  {

            #Användaren finns inte och vi kan fortsätta skapa konto
            New-ADUser `
                -SamAccountName $username `
                -UserPrincipalName "$username@$UPN" `
                -Name "$firstname $lastname" `
                -GivenName $firstname `
                -Surname $lastname `
                -Enabled $True `
                -DisplayName "$firstname $lastname" `
                -Path $OU `
                -City $city `
                -OfficePhone $telephone `
                -EmailAddress $email `
                -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True #Tänk på att ALLTID använda ConvertTo-secureString så att man inte kan använda Get-history för att se gamla ps-körningars pw

            # Om användaren är skapad skriv meddelande.
            Write-Host "Kontot $username är skapat!" -ForegroundColor Cyan

            New-Item $newusertxt
            Add-Content $newusertxt "Användare: $firstname $lastname Mejladress: $email  Användarnamn: $username  Lösenord: $password" -Encoding UTF8
   
        }
    }
}

else {
    exit
}

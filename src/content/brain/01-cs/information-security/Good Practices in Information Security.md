---
title: "Good Practices in Information Security"
---

Actions that help ensure information security:

- Never share passwords;
- Always use antivirus and keep it updated;
- Observe whether the sites accessed are reliable;
- Never open links or download files sent by unreliable emails or from unknown senders;
- Download programs only from official providers;
- Back up files regularly;
- Enable the operating system firewall;
- Keep the system always up to date.

### Managing Passwords

Some good practices on this matter:

- Passwords must have minimum of eight characters;
- Passwords must be changed frequently;
- In case of data leaking of some service, credentials must be changed;
- Passwords must have alphanumeric characters, such as @#$%&*, etc;
- Passwords must not contain user or company names;
- Not utilizing same password for multiple accounts;
- And of course, don't inform third parties about you passwords.

### Training

Independent of how much and how good a company security system is, if the worker do not had received training, a simple phishing attack can break all of the defenses.

## Antivirus, Access Control and Backup

### Access Control

- **DAC (Discretionary Access Control)**: In this method, the administrator of the system, data or protected resources defines the policies of who is allowed access, that is, the system holds the business owner responsible for deciding which people are allowed in a specific location, physically or digitally.
  DAC is less restrictive compared to other systems in that it essentially allows an individual complete control over whatever objects one owns, as well as the programs associated with those objects. The disadvantage of discretionary access control is that it gives the end user complete control to configure security level settings for other users. Furthermore, the permissions granted to the end user are inherited in other programs used, which can lead to the execution of malware, even if the end user is not aware of it.

- **MAC (Mandatory Access Control)**: This security mechanism restricts the level of control users (subjects) have over the objects they create. Unlike the DAC implementation, where users have full control over their own files, directories, etc., MAC adds additional labels or categories to all file system objects. Users and processes must have appropriate access to these categories before interacting with objects.
  To understand better, the subject is usually a process or thread while objects are constructs such as files, directories, TCP/UDP ports, shared memory segments, input and output devices. Subjects and objects have a set of security attributes. Whenever a subject tries to access an object, an authorization rule imposed by the operating system kernel examines these security attributes and decides whether access can take place.
- **RBAC (Role Based Access Control)**: Grants access based on defined business roles rather than user identity. The goal is to provide users only with access to data that they deem necessary to perform their role in organizations. This method is based on a combination of role assignments, authorizations, and permissions.

Access control is necessary to avoid hackers from accessing things they shouldn't, to protect computer and system resources to avoid safety problems. The main resources that need to be protected are **applications**, **data archives**, **operational system and utilities**, **password archives** and **log archives**.

### Login

An efficient login process should be:

1. Inform that the **system** should only be **accessed** by authorized persons;
2. **Do not display system information** until the logon process is completely complete;
3. Not to provide, during the logon process, **help messages** that could help an unauthorized user to access the system;
4. **Validate input data** only **after completing the login process**. The system must not indicate which part of the input data is correct or incorrect, such as, for example, ID or password, in case an error occurs;
5. **Limit the number of unsuccessful login attempts**, such as a maximum of three attempts;
6. **Save invalid access attempts** for future verification;
7. **Force a timeout before allowing new attempts to enter the system** or **reject any further attempts to access** without specific authorization.
8. **Terminate connections** to the system;
9. **Limit the time for the login procedure**. If it takes too long, the system should close the procedure;
10. When the system logon procedure finishes correctly, it shows the following information: **date and time** of the last successful logon; **details of any unsuccessful logon attempts** since the last successful procedure;

Imagine that you are programming the messages that will appear to the user during the logon process. According to the guidelines we saw, observe the messages that should or should not appear to the user:

| Passwords | Valid or invalid | Justification
|-----------|------------------|--------------
| Your password is incorrect. | Invalid |  This message must not appear for the user, as the system must not indicate which part of the input data is correct or incorrect, such as, for example, ID or password, in case of any error.
| Your login details are incorrect. You have two more attempts. | Valid | his message may appear to the user as the system must limit the number of unsuccessful login attempts, such as a maximum of three attempts.
| This system can be accessed by anyone. | Invalid | This message should not appear to the user. On the contrary, the system must inform that the system should only be accessed by authorized persons.

### Virus

1. All computers connected to an institution's network must have a standard antivirus program installed, scheduled to run at regular intervals. In addition, antivirus software and virus definition files should always be up to date;
2. All computers should be configured to schedule regular updates from the network services' centralized antivirus servers;
3. All data files and programs that have been transmitted electronically to a computer at another location, internal or external, must be scanned for viruses immediately upon receipt;
4. All storage devices, such as USB sticks and external hard drives, are a potential source of computer viruses. Therefore, they should be checked for virus infection before using them on a computer or network server;
5. Network computers and servers should never boot from an external device received from an external source;
6. Virus protection software must be loaded on each computer and network server as a resident program to constantly monitor possible virus attacks and prevent them from infecting the network;

### Backup

Companies should periodically do backup of data in order to prevent them from data deletion or data encryption in hacker attacks.

> **Attention !**
>
> It is important for companies to test backups to ensure that saved data can be restored and made available when needed.

## Cryptography and Digital Certificates

**Do you want to ensure data integrity?** Use hash functions. They are suitable for ensuring data integrity, because any change made to the content of a message will cause the receiver to calculate a different hash value than the one placed on the transmission by the sender.

**Do you want to guarantee privacy and confidentiality?** Use secret-key cryptography. It is ideal for encrypting messages, providing privacy and confidentiality. The sender can generate a session key to encrypt the message and the receiver will need the same session key to decrypt it.

**Do you want to perform the key exchange?** Use public key cryptography. This is an important application of this type of cryptography. Asymmetric schemes can also be used for non-repudiation and user authentication; if the recipient can obtain the session key encrypted with the sender's private key, then only the sender could have sent the message.

Main differences between them:

| Symmetric key | Asymmetric key | Hash function
|---------------|----------------|--------------
| Uses **unique key** to encrypt and decrypt message. | It uses a **key pair**, where one key is used for encryption and the other for decryption. | **It does not require any keys** for encryption and decryption.
| **It is faster**, but **less reliable** in terms of **security**. | **It is less fast**, but **more reliable** in terms of **security**. | **It is less fast**, but **more reliable** in terms of **security**.
| It was introduced to quickly run **cryptographic processes**. | It was introduced to **overcome the key exchange problem** in symmetric key. | It was introduced to provide **more security**.
| If for some reason the key is compromised/broken on the network, **both the sender and the receiver will be lost.** | There is **loss** only to the **owner**. | There is no key to compromise.
| It's **less complex**. | It's **more complex**. | It has **medium complexity**.

### Digital Certificates

The **digital certificate** is **an electronic document** that **identifies people and institutions**, proving identities and allowing access to computerized services that guarantee: **Authenticity**, **Integrity** and **Non repudiation**.

The digital certificate is also used to digitally sign documents. It is intended for any person, natural or legal, and is issued by a **Certification Authority (CA)**. With it, you can attach the public key, also called public key infrastructure − Public Key Infrastructure (PKI) −, to a specific individual or entity. An encrypted digital certificate must contain:

- The name of the subject (the organization or certified individual);
- The subject's public key (used to decrypt messages and digital signatures);
- A serial number (to uniquely identify the certificate);
- An expiration date;
- The digital signature of the certificate issuing authority and the message.
- Any other relevant information.

Digital certification in Brazil took off in 2001 when the federal government created the **Brazilian Public Key Infrastructure (ICP-Brasil -- It is a hierarchical chain of trust that enables the issuance of digital certificates for the virtual identification of citizens.)**, which has seen great growth since then. Certificates are used in several applications:

1. Automating the provision of tax information to the Federal Revenue of Brazil;
2. Electronic invoice;
3. Computerization of the Judiciary;
4. Computerization of notary services;
5. Computerization of processes for starting a business;
6. Computerization of medical and dental records;
7. Government purchases through electronic auction.

# Footer

- **Class**: Information Security
- **Theme**: Good Practices in Information Security
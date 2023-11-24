---
title: "Threats and Vulnerabilities to Information Security"
---

## Concepts and Types of Threats and Vulnerabilities

Institutions have their market value calculated based on their market share, products, patents, facilities, goods and information, that is, their assets. Assets can be classified as tangible, when it is possible to measure their value, and as intangible, when it is difficult or impossible to measure their value.

Tangible Assets:

- Logical: They involve information and its representation in an algorithm, such as a chemical formula or software source code;
- Physical: Those we can touch;
- Human: Those that refers to the collaborators and service workers.

The management of those assets are important to keep things working in an enterprise. For example, when Steve Jobs (fits in human asset) died, Apple titles have fallen in prices.

**How to relate a threat and a vulnerability? Let's think of an example based on a children's drawing, the Road Runner.**

In the animation, the coyote was trying to throw an anvil at the bird, but let's change our actors. Instead of the bird, let's imagine a soft drink, whose formula is saved on an external storage device (pen drive). In this case, the anvil is a threat against our device. To protect our pen drive, we can place it inside a super-resistant metal box. Of course, we create a protection (control) against the threat (anvil).

Obviously, creating protections for everything is too much. Fires and floods can happen, but is necessary to make a study about the location to know better what have high and lower chances to occur in order to create protections against the worst threats for the target.

### Types of Threats and Vulnerabilities - How to Prevent?

*Obs: Remembering principles - confidentiality, availability and integrity.

- Threat: Account invasion on WhatsApp; Recommendation is the use of two factor auth;

More examples:

| Security | Threat	| Prevent Method
|----------|--------|---------------
| Confidentiality	| Unauthorized access | Use of passwords
| | Unauthorized access	| Use of encryption
| | Loss of backup tapes during transport	|
| Integrity	| Alteration of data by unauthorized person/software/process | Use of authentication methods
| | Data corruption | Use of hashes
| Availability | Phenomena arising from natural causes, such as fire and floods	| Use of backup servers and/or redundancies
| | Denial of Service Attacks	| Use of Redundancy Servers

Or using, instead of the principles, the logical or physical definition of threat:

| Security | Threat | Prevent Method
|----------|--------|---------------
| Physical | Phenomena arising from natural causes, such as fire and flooding | Use of backup servers and/or redundancies
| | Backup tapes lost during transport | Use of encryption
| Logic | Data alteration by unauthorized person/software/process | Use of authentication methods
| | Data corruption | Use of hashes
| | Listen on call or network traffic | Use encryption
| | Denial of Service Attacks | Use of Redundancy Servers
| | Unauthorized access | Use of passwords

Human threats are those that were caused by humans, and non-human threats are caused by nature or infrastructure problems. Non-human threats can also be classified into threats arising from disasters or infrastructure problems. Human threats can also be classified in two different types:

- Collaborators: Those from employees or malicious people and those from people or employees who do not have adequate knowledge (poorly trained);
- Hackers: Those from hackers who exploit vulnerabilities to demonstrate knowledge and show off their achievement to the community; or even the simple challenge of reaching the goal, as if it were a game; or even to obtain financial gains from obtaining assets from institutions.

Classifications of threats:

| Classification type | Threat type
|---------------------|------------
| Regarding the type of asset involved | <ul><li>Related to Confidentiality</li><li>Related to Integrity</li><li>Related to Availability</li></ul>
| As for the attack vector | <ul><li>Physical</li><li>Logic</li><li>Human</li><li>Not human</li></ul>
| As for the phenomenon that gave rise (subclassification of non-humans) | <ul><li>natural disaster</li><li>Infrastructure</li></ul>

In the case of a flood in a data center, the main issue generated is availability. Depending on the controls (protections) chosen by the manager, even data integrity problems can be generated. Therefore, it is always necessary to carry out the layered approach. In this scenario, some simple controls could be developed such as:

- Contingency: development of some technique/methodology to supply the absence or failure of the data center;
- Contingency use process and training;
- Process and realization of backup copies, as well as verification of the status of these copies, including disaster simulation.

## Techniques for Cyber Attacks

### Attacks

Cyber threats are realized through the use of techniques that typically exploit the vulnerability of a technology, process or methodology. The reasons and motivations have already been explained, but we can summarize them as the stimulus to obtain certain information (injuring confidentiality), damaging information (injuring integrity) and interrupting the functioning of a certain system (injuring availability).

- Attacks of Denial of Service (DOS): It corresponds to a type of attack that aims to make a certain system or equipment unavailable. In this type of attack, vulnerabilities in software, equipment and algorithms/protocols are exploited. Examples are pod (ping of death), syn flood, udp flood and tcp flood. These attacks exploit vulnerabilities in the implementation of some network service, operating system or protocol used;
- Social Engineering: Situation in which human weaknesses are used to obtain information (injure the confidentiality) of a person or organization. The most common example of this type of attack is phishing, commonly used to obtain credit card data for financial gain;
- Site Graffiti: Is characterized by the unauthorized alteration of a certain website on the Internet. The vulnerabilities of the portals are explored and, through this, the modifications are carried out;
- Botnets: Also known as a zombie network, it is a set of equipment that has suffered an attack, resulting in the control of the equipment by the hacker. Bots are similar to worms in terms of how they proliferate, but differ in that they follow orders from the command and control centers (equipment whose purpose is to orchestrate the attack, allowing the maintenance of the hacker's secrecy). Through botnets it is possible to carry out denial of service attacks, mass e-mails and many others.

Another techniques used in cyber attacks:

- IP Spoofing: It occurs when the attacker forges his IP address, putting another value in this field, pretending to be the source of the data from another origin. It is very common for exploiting the protocol vulnerability;
- Pharming or DNS Cache Poisoning: It occurs when the DNS servers are attacked, aiming to change the exchange of domain names for IP addresses and, thus, targeting the victim with fake equipment and software. Exploits vulnerabilities in certain implementations and brands of equipment. It is a difficult technique to be identified by the end user;
- IP Session Hijacking: Occurs when the connection between the client and the server on the internet is performed through the exchange of HTTP request and response commands, for example. During this process, it is common to have a user session (HTTP Session) configured and running, in order to identify the user accessing the portal. One of the techniques used, either to break user confidentiality or to carry out an attack on the portal, is user session hijacking. Soon, the attacker captures this exchange of information and pretends to be one of the equipment. It is a technique with a certain degree of sophistication and difficult to be identified by network managers and end users;
- Brute Force: Occurs when passwords in information systems are encoded on the server. Coding can be performed using proprietary techniques of the system, where specific coding algorithms are developed, or through condensation functions, also known as hashing. Password crackers can use special sets of tables, known as rainbow tables, or even testing all possible combinations, called brute force. In this technique, the attacker's degree of knowledge will determine the effectiveness of the attack;
- Hash: Occurs when some algorithms are created using algebraic manipulations that transform the input data into a finite set of hexadecimal numbers, called the hash of the data. These manipulations prevent initial values from being retrieved from the generated data;
- Trashing Dumpster Diving: It occurs when searches are carried out in corporate waste in the expectation that some improper disposal has been carried out. This brings us back to the first module, where we deal with the information life cycle. If the disposal is not done properly, techniques like this allow the recovery of information straight from the trash. In many countries, there is no legislation that makes this technique illegal;
- Wardriving: Occurs when the search for physical locations contains an unprotected Wi-Fi signal in order to exploit the vulnerability found. In this technique, the intruder travels through public spaces looking for unprotected signs, whether on foot, by car or using drones.

### Malicious Software

Malware is malicious software that aims to infect IT assets. In this category, there is a very large variation and with different types. Examples include advertising-related Trojan horses, misused support tools, exploits, and worms.

Advertising-related viruses such as spyware (for example, applications that capture everything the user types, known as keyloggers) and adware (applications that deliver advertising to the user without his authorization) monitor the user in some way, aiming to explore the human behavioral aspect.

There is also the malicious use of supporting tools such as network sniffers and port scanners. The first allows you to analyze the network traffic and the second allows you to check which are the communication ports of the transport layer protocols that are available for connection.

### Ransomware

Malicious software, with high reproducibility power, that invades the victim's machine, encrypts his data and requests a ransom. In recent years, this type of attack has been quite frequent, with WannaCry as an emblematic case.

# Footer

- **Class**: Information Security
- **Theme**: Threats and Vulnerabilities to Information Security
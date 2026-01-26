# Audit de Sécurité Cloud Automatisé (AWS)

![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Prowler](https://img.shields.io/badge/Security-Prowler-green?style=for-the-badge)

##  Objectif du Projet
Ce projet démontre une approche **DevSecOps** appliquée à l'infrastructure cloud. L'objectif est de déployer une infrastructure via du code (IaC), de détecter automatiquement des erreurs de configuration de sécurité critiques (ici, un port SSH 22 ouvert sur tout Internet) et de valider les corrections.

Objectifs :
* Utiliser l'**Infrastructure-as-Code** (Terraform) pour gérer des ressources AWS.
* Implémenter un **pipeline CI/CD** de sécurité avec GitHub Actions.
* Utiliser des outils d'audit de sécurité standard de l'industrie (**Prowler**).
* Appliquer le principe de remédiation immédiate.

##  Architecture et Flux de Travail

Le projet suit le cycle de vie suivant :

1.  **Déploiement (IaC) :** Création d'un Security Group AWS via Terraform.
2.  **Audit Automatisé :** À chaque `push` sur la branche `main`, un workflow GitHub Actions lance **Prowler**.
3.  **Détection :** Prowler scanne la configuration et alerte si le port 22 est ouvert sur `0.0.0.0/0`.
4.  **Remédiation :** Modification du code Terraform pour restreindre l'accès à une IP admin unique.

##  Technologies Utilisées

* **AWS (EC2 / VPC Security Groups)** : Cible de l'infrastructure.
* **Terraform** : Provisionnement de l'infrastructure (IaC).
* **Prowler** : Outil open-source de sécurité pour les audits de bonnes pratiques AWS et conformité (CIS, etc.).
* **GitHub Actions** : Orchestration du pipeline d'audit continu.

##  Scénario de Sécurité : La Faille SSH

### 1. État Initial (Vulnérable)
L'infrastructure a été initialement déployée avec une règle `ingress` permissive, exposant le port SSH au monde entier. C'est une mauvaise configuration critique (Risque élevé).

```hcl
# Code vulnérable (Simulé)
ingress {
  from_port   = 22
  to_port     = 22
  cidr_blocks = ["0.0.0.0/0"] # ⚠️ DANGER : Ouvert à tous
}

2. Détection par Prowler
Le pipeline CI/CD a exécuté le check 

ec2_securitygroup_allow_ingress_from_internet_to_tcp_port_22.

3. Correction (Sécurisé)

Le code a été corrigé pour n'autoriser que l'IP de l'administrateur.

# Code corrigé (Actuel)
ingress {
  description = "SSH restreint a une adresse IP interne (Admin)"
  from_port   = 22
  to_port     = 22
  cidr_blocks = ["10.0.0.5/32"] # ✅ SÉCURISÉ
}

Comment reproduire ce projet
Prérequis
Un compte AWS actif.

Un compte GitHub.

Terraform installé localement (pour les tests manuels).

Installation
Cloner le dépôt :

git clone [https://github.com/ablayeT/AWS_Automated_Cloud_Security_Audit.git](https://github.com/ablayeT/AWS_Automated_Cloud_Security_Audit.git)
cd AWS_Automated_Cloud_Security_Audit

Configurer les Secrets GitHub : Dans les paramètres du dépôt (Settings > Secrets and variables > Actions), ajoutez :

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Lancer l'audit : Effectuez un commit et un push sur la branche main. L'onglet "Actions" de GitHub affichera le déroulement du scan Prowler.

Projet réalisé dans le cadre de ma montée en compétence en Cybersécurité Cloud.

<div align="center"> <sub>Developppé par Abdou<b>Abdou</b> - Cybersecurity Lab</sub> </div>

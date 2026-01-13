provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg_passoire" {
  name        = "sg_vulnerable_ssh"
  description = "Security Group intentionnellement vulnerable pour Audit"

  # --- PHASE 1 : VERSION VULNÉRABLE (ACTIVE) ---
  # On laisse le port 22 ouvert à tout Internet (0.0.0.0/0)
  # C'est ce bloc qui va déclencher l'alerte Prowler
  ingress {
    description = "SSH ouvert au monde entier"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # --- PHASE 2 : VERSION SÉCURISÉE (COMMENTÉE) ---
  # On garde ça pour l'étape suivante (la correction)
  # ingress {
  #   description = "SSH restreint a une adresse IP interne (Admin)"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["10.0.0.5/32"]
  # }

  # Regle de sortie standard
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
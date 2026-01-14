provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg_passoire" {
  name        = "sg_vulnerable_ssh"
  description = "Security Group intentionnellement vulnerable pour Audit"

  # --- PHASE 1 : VERSION VULNÉRABLE (DÉSACTIVÉE/CORRIGÉE) ---
  # La règle ci-dessous est maintenant commentée. Le port n'est plus ouvert à tous.
  # ingress {
  #   description = "SSH ouvert au monde entier"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"] 
  # }

  # --- PHASE 2 : VERSION SÉCURISÉE (ACTIVE) ---
  # Cette règle est maintenant active. Elle restreint l'accès SSH à une seule IP.
  ingress {
    description = "SSH restreint a une adresse IP interne (Admin)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Seule l'IP 10.0.0.5 est autorisée (Simulation d'une IP d'entreprise)
    cidr_blocks = ["10.0.0.5/32"]
  }

  # Regle de sortie standard (On laisse sortir le trafic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
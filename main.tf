provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg_passoire" {
  name = "sg_vulnerable_ssh"
  # CORRECTION ICI : On retire les accents
  description = "Security Group intentionnellement vulnerable pour Audit"

  # Regle d'entree (Ingress) : C'est ici qu'est la faille !
  ingress {
    description = "SSH ouvert au monde entier"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # 0.0.0.0/0 signifie "Toutes les adresses IP de la Terre"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regle de sortie (Egress) : On laisse tout sortir (standard)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

from django.db import models

class Peca(models.Model):
    tag = models.CharField(max_length=100)
    tipo = models.CharField(max_length=100)
    imagem = models.ImageField(upload_to='pecas/', null=True, blank=True)

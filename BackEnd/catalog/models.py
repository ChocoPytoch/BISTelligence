from django.db import models

# Create your models here.

class Data(models.Model):
    Score = models.FloatField()
    Key = models.IntegerField(default=0)

class Xai(models.Model):
    summary_plot = models.ImageField(upload_to="")
    force_plot = models.ImageField(upload_to="")

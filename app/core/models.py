from django.db import models


class Sample(models.Model):
    attachment = models.FileField()

    # def __str__(self) -> str:
    #     return self.attachment

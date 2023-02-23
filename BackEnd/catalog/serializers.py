from rest_framework import serializers
from .models import Data, Xai

class DataSerializer(serializers.ModelSerializer):
    class Meta:
        model = Data
        fields = ['Score', 'Key']


class XaiSerializer(serializers.ModelSerializer):
    summary_plot = serializers.ImageField(use_url=True)
    force_plot = serializers.ImageField(use_url=True)
    class Meta:
        model = Xai
        fields = ['summary_plot', 'force_plot']
        
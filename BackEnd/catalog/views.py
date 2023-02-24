from django.shortcuts import render
from django.http import HttpResponse, StreamingHttpResponse, JsonResponse
from rest_framework.response import Response
from rest_framework import viewsets
from rest_framework.decorators import action
from .models import Data, Xai
from .serializers import DataSerializer, XaiSerializer
import joblib
import pandas as pd
import json
import numpy as np
import os
import sys
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))))
import src.evaluate as ev

BIS_path = os.path.abspath(os.path.dirname(os.path.abspath(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))))

class DataView(viewsets.ModelViewSet):
    
    Data.objects.all().delete()
    
    for key in range(1,7):
        ev.SetData(scaled = True, key_num = key)
        model = ev.LoadModel('LOF',BIS_path + '/'+'src/model/best_model',key_num = key)
        score = ev.GetAnomalyScore(model)
    
        s = pd.DataFrame(score, columns = ['Score'])
        ss = []
        for i in range(len(s)):
            st = (s['Score'][i])
            ss.append(st)

        for i in range(len(s)):
            Data.objects.create(
                Key = key,
                Score=ss[i],
                    )
       
    queryset = Data.objects.all()
    serializer_class = DataSerializer
    
    #url : data/ScoreUpdate/
    @action(detail=False, methods=['GET'])
    def ScoreUpdate(self, request):
        self.user_data = request.data
        self.key = self.user_data["Key"]
        print("user_data : {}".format(self.user_data))

        qs = self.queryset.filter(Key=self.key)
        serializer = self.get_serializer(qs, many=True)
        return Response(serializer.data)
    



class XaiView(viewsets.ModelViewSet):
    Xai.objects.all().delete()
    queryset = Xai.objects.all()
    serializer_class = XaiSerializer

    def DrawPlot(self, key=1, threshold=1, index=0):
        model_name = "LOF"
        ev.SetData(scaled = True, key_num = key)
        model = ev.LoadModel(model_name,BIS_path + '/'+'src/model/best_model',key_num = key)

        ev.DoXAI(model, key_num = key, threshold=threshold, plot_type=0)
        ev.DoXAI(model, key_num = key, threshold=threshold, plot_type=1, sample_index=index)

        summary_png = '{}_key{}_type{}.png'.format(model_name, key, 0)
        force_png = '{}_key{}_type{}.png'.format(model_name, key, 1)

        return summary_png, force_png

    #url : xai/PlotUpdate/
    @action(detail=False, methods=['GET'])
    def PlotUpdate(self, request):
        self.user_data = request.data
        self.key = self.user_data["key"]
        self.threshold = self.user_data["threshold"]
        self.index = self.user_data["index"]
        print("user_data : {}".format(self.user_data))
        Xai.objects.all().delete()

        summary_png, force_png = self.DrawPlot(key=self.key, threshold=self.threshold, index=self.index)
        Xai.objects.create(summary_plot = summary_png, force_plot = force_png)
        print('model saved in XAI')

        self.queryset = Xai.objects.all()
        serializer = self.get_serializer(self.queryset, many=True)
        return Response(serializer.data)
    
    
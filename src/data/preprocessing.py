#for return data

import pandas as pd

import warnings
warnings.filterwarnings(action='ignore')

from sklearn.preprocessing import RobustScaler

def GetData(path:str):
  data=pd.read_csv(path)
  return data

def SetNormalData(data, num):
  normal_df = pd.DataFrame()

  for key in data['key'].unique():
    df = data.loc[data.key == key][:num]
    normal_df = pd.concat([normal_df, df])
  
  normal_index = normal_df.index
  normal_df.reset_index(drop=True, inplace=True)

  return normal_df, normal_index

def ImputateData(data):
  prev_sum=data[data['key']==4].loc[942:981]['Vibration_RMS2'].sum()
  after_sum=data[data['key']==4].loc[983:1022]['Vibration_RMS2'].sum()
  aver=(prev_sum+after_sum)/80
  data.loc[data['Vibration_RMS2']<0,'Vibration_RMS2']=aver

  return data

def GetPreprocessedData(path:str , scaled=False, normal_num=120):
 
  data = GetData(path)
  
  data = ImputateData(data)
  normal_df, _ = SetNormalData(data, normal_num)

  train_data = normal_df.drop(['key'],axis=1)
  test_data = data.drop(['key'],axis=1)

  if(scaled):
    train_data, test_data = ScaledData(train_data, test_data)

  return train_data, test_data

def ScaledData(train_data, test_data):
  scaler=RobustScaler()
  train_data=pd.DataFrame(scaler.fit_transform(train_data),columns=train_data.columns)
  test_data=pd.DataFrame(scaler.transform(test_data),columns=test_data.columns)
  return train_data, test_data
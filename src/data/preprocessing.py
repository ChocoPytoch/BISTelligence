#for return data

import pandas as pd
import joblib
import warnings
from pandas.core.internals.blocks import putmask_smart
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
  '''
  [mean imputation]
  prev_sum=data[data['key']==4].loc[942:981]['Vibration_RMS2'].sum()
  after_sum=data[data['key']==4].loc[983:1022]['Vibration_RMS2'].sum()
  aver=(prev_sum+after_sum)/80
  data.loc[data['Vibration_RMS2']<0,'Vibration_RMS2']=aver
  '''
  cp_data = data.copy()
  data_key_4 = cp_data.loc[cp_data.key==4]
  noisy_data = data_key_4.loc[data_key_4['Vibration_RMS2']<0]
  X = noisy_data.drop(['key','Vibration_RMS2'],axis=1)
  
  #load linear regression model
  path='/content/drive/MyDrive/bistelligence/BISTelligence/src/model/saved_model/model_LinearRegression.pkl'
  lr_model = joblib.load(path)
  y_pred = lr_model.predict(X)
  cp_data.loc[data['Vibration_RMS2']<0, 'Vibration_RMS2'] = y_pred
  

  return cp_data

def GetPreprocessedData(path:str , scaled=True, normal_num=70,
                        key_num=-1):
 
  data = GetData(path)

  data = ImputateData(data)

  if key_num>=1 and key_num<=6:
    data = data.loc[data.key==key_num]
    
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
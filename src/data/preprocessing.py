#for return data

import pandas as pd
import joblib
import warnings
# from pandas.core.internals.blocks import putmask_smart
warnings.filterwarnings(action='ignore')

from sklearn.preprocessing import RobustScaler
import os, sys
src_path = os.path.abspath(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))

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

def SetFakeLabeling(data=None, pseudo_labeling=False, anomaly_rate=0.1):
  '''
  Args:
    data(DataFrame): Data for analysis
    pseudo_labeling(bool): Use unsupervised learned model or not
    anomaly_rate(float): if pseudo_labeling parameter is False, set anomaly rate for fake labeling
  '''
  data_cp = data.copy()
  labeled_data = pd.DataFrame()

  if pseudo_labeling:
    pass

  else:
    for key in data_cp['key'].unique():
        df_each_key = data_cp.loc[data_cp.key==key]
        threshold_fake_label = int(len(df_each_key)-(len(df_each_key)*anomaly_rate))
        
        # 0: normal / 1: anomaly
        df_each_key['target'] = 0
        df_each_key['target'][threshold_fake_label:] = 1
        labeled_data = pd.concat([labeled_data, df_each_key])

  labeled_data.reset_index(drop=True, inplace=True)

  return labeled_data, labeled_data.index

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
  path= src_path + '/model/saved_model/model_LinearRegression.pkl'
  lr_model = joblib.load(path)
  y_pred = lr_model.predict(X)
  cp_data.loc[data['Vibration_RMS2']<0, 'Vibration_RMS2'] = y_pred


  return cp_data

def GetPreprocessedData(path:str , scaled=True, train_num=70,
                        labeling=False, data_type=1,
                        pseudo_labeling=False, anomaly_rate=0.05) -> tuple[pd.DataFrame, pd.DataFrame, pd.Series, pd.Series]:
  '''
  Args:
    path(str): data path
    scaled(bool): Do data scaling or not
    train_num(int): Number of data for training; Number of data considered normal with a high probability based on the user's insights
    labeling(bool): Do fake labeling or not
    data_type(int): Data type; (key 1~4) -> type 1, (key 5,6) -> type 2
    pseudo_labeling(bool): Use unsupervised learned model or not
    anomaly_rate(float): Rate of data considered anomaly with a high probability based on the user's insights

  Return:
    train_data, test_data(pandas.DataFrame)
    train_target, test_target(pandas.Series): 0: normal, 1: anomaly
  '''

  data = GetData(path)

  data = ImputateData(data)

  if data_type==1:
    data = data.loc[data.key<=4]

  elif data_type==2:
    data = data.loc[data.key>=5]

  else:
    raise Exception("data type invalid")

  data['target'] = -1 # initialize 'target'

  if labeling:
    data, _ = SetFakeLabeling(data=data, pseudo_labeling=pseudo_labeling, anomaly_rate=anomaly_rate)

  normal_df, _ = SetNormalData(data, train_num)

  train_target = normal_df['target']
  train_data = normal_df.drop(['key','target'],axis=1)
  test_target = data['target']
  test_data = data.drop(['key','target'],axis=1)

  if(scaled):
    train_data, test_data = ScaledData(train_data, test_data)

  return train_data, train_target, test_data, test_target

def ScaledData(train_data, test_data):
  scaler=RobustScaler()
  train_data=pd.DataFrame(scaler.fit_transform(train_data),columns=train_data.columns)
  test_data=pd.DataFrame(scaler.transform(test_data),columns=test_data.columns)
  return train_data, test_data
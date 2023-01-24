#for model

import numpy as np
import seaborn as sns
import random
import os
from pyod.models.auto_encoder import AutoEncoder
from pyod.models.mcd import MCD
from sklearn.ensemble import IsolationForest
from sklearn.svm import OneClassSVM
from sklearn.decomposition import PCA
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import LocalOutlierFactor
from sklearn.mixture import GaussianMixture
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers,losses,models
from tensorflow.keras.models import Model, load_model
from keras.callbacks import EarlyStopping, ModelCheckpoint

class BaseModel:

  def GetMCD(contamination,random_state):

    model_mcd = MCD(contamination=0.01,random_state=42)

    return model_mcd

  def GetOCSVM(nu):

    model_ocsvm = OneClassSVM(nu=0.01)

    return model_ocsvm

  def GetLOF(contamination, novelty):

    model_lof = LocalOutlierFactor(contamination=0.01,novelty=True)

    return model_lof

  def GetIForest(contamination):
    
    model_iforest = IsolationForest(contamination = 0.01)

    return model_iforest

  def GetGMM(n_components, cv_type):
    model_gmm = GaussianMixture(
      n_components=n_components,
      covariance_type=cv_type
    )
    return model_gmm

  def GetAE(momentum, train_shape, random_state):
    def my_seed_everywhere(seed: int = 2):
      random.seed(seed) # random
      np.random.seed(seed) # np
      os.environ["PYTHONHASHSEED"] = str(seed) # os
      tf.random.set_seed(seed) # tensorflow

    my_seed = random_state
    my_seed_everywhere(my_seed)

    input_dim=train_shape[1]
    #tf.random.set_seed(2)
    initializer = tf.keras.initializers.HeNormal(seed=random_state)
    momentum = momentum
    
    encoder=models.Sequential([
        #input layer
        layers.InputLayer(input_shape=input_dim),

        layers.Dense(64,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        layers.Dense(32,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        layers.Dense(16,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        layers.Dense(8,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        layers.Dense(4,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
    ])

    decoder=models.Sequential([ 
        
        layers.Dense(4,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        layers.Dense(8,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        layers.Dense(16,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        layers.Dense(32,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        layers.Dense(64,kernel_initializer=initializer),
        layers.BatchNormalization(momentum=momentum),
        layers.ReLU(),
        
        #output layer
        layers.Dense(input_dim,kernel_initializer=initializer),
    ])

    model_ae = models.Sequential([
        encoder,decoder
    ])

    return model_ae

class ModelTrain:

  def __init__(self):
    self.param_dict={'contamination':0.01,
                     'nu':0.01,
                     'novelty':True,
                     'random_state':42,
                     'n_conponents':1,
                     'cv_type':'full',
                     'momentum':0.9,
                     'learning_rate':0.03,
                     'epochs':100,
                     'patience':10}

  def SetTrainer(self, train_data):
    self.train_data = train_data

  def SetParam(self, param_dict={}):
    self.param_dict.update(param_dict)

  def GetTrainedModel(self,model_name="MCD"):
    model = 0
    if model_name == 'MCD':
      model = BaseModel.GetMCD(
        self.param_dict['contamination'],
        self.param_dict['random_state']
      )
      model.fit(self.train_data)
    
    elif model_name == 'OCSVM':
      model = BaseModel.GetOCSVM(
        self.param_dict['nu']
      )
      model.fit(self.train_data)
    
    elif model_name == 'IForest':
      model = BaseModel.GetIForest(
        self.param_dict['contamination']
      )
      model.fit(self.train_data)

    elif model_name == 'LOF':
      model = BaseModel.GetLOF(
        self.param_dict['contamination'],
        self.param_dict['novelty']
      )
      model.fit(self.train_data)
    
    elif model_name == 'GMM':
      model = BaseModel.GetGMM(
        self.param_dict['n_components'],
        self.param_dict['cv_type']
      )
      model.fit(self.train_data)
    
    elif model_name == 'AE':
      model = BaseModel.GetAE(
        self.param_dict['momentum'],
        self.train_data.shape,
        self.param_dict['random_state']
      )
      

      early_stopping = EarlyStopping(monitor='val_loss', mode='min', verbose=1,patience=self.param_dict['patience'])
      check_point = ModelCheckpoint('best_ae_model.h5',monitor='val_loss',mode='min',save_best_only=True)

      model.compile(optimizer=keras.optimizers.Adam(learning_rate = self.param_dict['learning_rate']), 
                        loss=keras.losses.MeanSquaredError())
      history = model.fit(
        self.train_data,self.train_data,
        shuffle=True,
        epochs=self.param_dict['epochs'],
        batch_size=128,
        validation_split = 0.3,
        callbacks = [early_stopping, check_point],
        verbose = 0
    )

    else:
      raise 'you can choose in ["MCD", "IForest", "OCSVM", "LOF", "GMM", "AE"]'

    return model

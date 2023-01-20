#for model

import numpy as np
import seaborn as sns
from pyod.models.iforest import IForest
from pyod.models.auto_encoder import AutoEncoder
from pyod.models.mcd import MCD
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

def MinimumCovarianceDeterminant(train=None,test=None):
  model_mcd = "MCD"
  model_mcd = MCD(support_fraction=0.8,contamination=0.01,random_state=42)
  model_mcd.fit(train)
  mcd_anomaly_score = model_mcd.decision_function(test)
  sns.scatterplot(test.index,mcd_anomaly_score)
  return model_mcd

def OneClassSVM(train=None,test=None):
  model_ocsvm = "OCSVM"
  model_ocsvm = OneClassSVM(nu=0.01)
  model_ocsvm.fit(train)
  ocsvm_anomaly_score = model_ocsvm.decision_function(test)
  sns.scatterplot(test.index,ocsvm_anomaly_score)
  return model_ocsvm

def LocalOutlierFactor(train=None,test=None):
  model_lof = "LOF"
  model_lof = LocalOutlierFactor(contamination=0.01,novelty=True)
  model_lof.fit(train)
  lof_anomaly_score = model_lof.decision_function(test)
  sns.scatterplot(test.index,lof_anomaly_score)
  return model_lof

def IsolationForest(train=None,test=None):
  model_iforest = "IForest"
  model_iforest = IForest(contamination=0.01,random_state=42,max_samples=300,n_estimators=200)
  model_iforest.fit(train)
  isof_anomaly_score = model_iforest.decision_function(test)
  sns.scatterplot(test.index,isof_anomaly_score)
  return model_iforest

def GausianMixtureModel(train=None,test=None):
  model_gmm = "GMM"
  lowest_bic = np.infty
  bic = []
  n_components_range = range(1,5)
  cv_types = ["spherical", "tied", "diag", "full"]
  for cv_type in cv_types:
      for n_components in n_components_range:
          gmm = GaussianMixture(
              n_components=n_components, covariance_type=cv_type
          )
          gmm.fit(train)
          bic.append(gmm.bic(train))
          if bic[-1] < lowest_bic:
              lowest_bic = bic[-1]
              model_gmm = gmm

  gmm_anomaly_score = model_gmm.score_samples(test)
  sns.scatterplot(test.index,gmm_anomaly_score)
  return model_gmm

def AutoEncoder(train=None,test=None):
  model = "AE"
  return model
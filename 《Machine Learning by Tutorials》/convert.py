import coremltools as ct 
import tensorflow as tf
import os
import numpy as np

savedPath = "/Users/styf/Downloads/saved_model"
#savedPath = "/Users/styf/Downloads/imagenet_mobilenet_v2_050_192_classification_5"
#model = tf.saved_model.load(savedPath)
#print(model)
#mlmodel = ct.convert(savedPath, convert_to="mlprogram")
#mlmodel = ct.convert(model, source="tensorflow", convert_to="mlprogram")
#mlmodel = ct.convert(model, convert_to="mlprogram")
# mlmodel = ct.convert(savedPath)

txt_path = '/Users/styf/Downloads/labels.txt'
f = open(txt_path)
data_lists = f.readlines()
class_labels= []
for data in data_lists:
	data1 = data.strip('\n')
	class_labels.append(data1)
# class_labels = np.array(class_labels)
print(class_labels)

classifier_config = ct.ClassifierConfig(class_labels)

image_input = ct.ImageType()
mlmodel = ct.convert(savedPath,inputs=[image_input],classifier_config=classifier_config) #,outputs=["output"]
mlmodel.save("/Users/styf/Downloads/Styf.mlmodel")


print("TF Model has been converted top CoreML Model")

# ❌ 虽然转换未报错，也能正常通过编译，但是实际使用却无效
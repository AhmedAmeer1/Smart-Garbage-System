
import cv2
from  gui_buttons import Buttons

#Initialize Button
button= Buttons()
button.add_button("glass",20,20)
button.add_button("cardboard",20,120)
button.add_button("paper",20,220)
button.add_button("plastic",20,320)
button.add_button("metal",20,420)
button.add_button("trash",20,520)

#Opencv DNN
net = cv2.dnn.readNet("dnn_model/yolov4-tiny.weights","dnn_model/yolov4-tiny.cfg")
model = cv2.dnn_DetectionModel(net)
model.setInputParams(size=(320,320),scale=1/255)

#Load class list
classes = []
with open("dnn_model/classes.txt") as file_object:
    for class_name in file_object.readlines():
        class_name=class_name.strip()
        classes.append(class_name)

print("classes")
print(classes)

# this to capture video from webcam it works as array if 0 webcam one if it is 1 it will show to we cam 2

#Initialaize camera
cap = cv2.VideoCapture(0)
#Ajust size of frame resolution
cap.set(cv2.CAP_PROP_FRAME_WIDTH,1280)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT,720)

button_person =False

def click_button(event,x,y,flags,params):
    global button_person
    if event == cv2.EVENT_LBUTTONDOWN:
        button.button_click(x,y)


#create window
cv2.namedWindow("Frame")
cv2.setMouseCallback("Frame",click_button)

#We have to put lop to get real time frame
while True:
    #get frames
    # ret is to handle if frame does not opens or to handle error handling frame is to handle image that we captured from camera
    ret, frame = cap.read()

    #get active button list
    active_buttons=button.active_buttons_list()
    print("Active buttons ",active_buttons)

    #object Detection
    (class_ids,scores,bboxes)= model.detect(frame)
    for class_id,score,bbox in zip(class_ids,scores,bboxes):
        (x,y,w,h)=bbox
        class_name =classes[class_id]
        print(class_name)

        if class_name in active_buttons :
            # put text on rectangle
            cv2.putText(frame, class_name + "  " + str(score), (x, y - 10), cv2.FONT_HERSHEY_PLAIN, 1, (200, 0, 50), 2)

            # draw rectangle on object
            # param 1 :where to draw recatangle param 2 :size param 3 :colour
            cv2.rectangle(frame, (x, y), (x + w, y + h), (200, 0, 50), 2)

    #Display button
    button.display_buttons(frame)

    #show capture in window/screen (name of the frame,captured item)
    cv2.imshow("Frame",frame)

    #it will closes imdiattley because of programme ending so we have to make it wait
    cv2.waitKey(1)
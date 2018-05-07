class Emotion
{
  String description;
  Emotion(String initEmotion)
  {
    description = initEmotion;
  }
}

class Person
{
  String name;
  Emotion currentEmotion;  
  Person(Emotion initialEmotion, String inputName)
  {
    name = inputName;
    currentEmotion = initialEmotion;
  }
  void updateEmotion(Emotion newEmotion)
  {
    currentEmotion = newEmotion;
  }
}

class Network
{

}
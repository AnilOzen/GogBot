class Emotion
{
  String description;
}

class Person
{
  Emotion currentEmotion;  
  Person(Emotion initialEmotion)
  {
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
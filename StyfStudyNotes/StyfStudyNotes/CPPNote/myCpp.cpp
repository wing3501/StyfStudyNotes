//
//  main.cpp
//  OhMyCPP
//
//  Created by styf on 2019/12/6.
//  Copyright © 2019 styf. All rights reserved.
//

#include <iostream>
using namespace std;

namespace MJ {
    int m_haha;
    class Person {
        int m_age;
    };
}


//void swap(int &v1,int &v2) {
//    int tmp = v1;
//    v1 = v2;
//    v2 = tmp;
//}
//
//int add(const int &v1,const int &v2) {
//    return v1 + v2;
//}
//
//struct Person {
//    int age;
//
//    Person() {
//        memset(this, 0, sizeof(Person));
//    }
//
//    ~Person() {
//
//    }
//
//    void run(){
//        cout << "Person::run() - " << age << endl;
//    }
//};
//
//class Student {
//private:
//    int m_age;
//public:
//    void setAge(int age);
//};
//
//void Student::setAge(int age) {
//    m_age = age;
//}
//
////struct Student : Person {
////    int m_score;
////    void study(){}
////};
//
//struct Person1 {
//    int m_age;
//    int m_height;
////    Person1(int age,int height){
////        m_age = age;
////        m_height = height;
////    }
//
//    Person1(int age,int height):m_age(age),m_height(height){
//
//    }
//};
//-----------------------多态
//struct Animal {
//    virtual void speak() {
//        cout << "Animal::speak()" << endl;
//    }
//};
//
//struct Dog : Animal {
//    void speak() {
//        cout << "Dog::speak()" << endl;
//    }
//};

//-----------------------纯虚函数
//struct Animal {
//    virtual void speak() = 0;
//};

//-----------------------虚继承
//struct Person {
//    int m_age;
//};
//
//struct Student : virtual Person{
//    int m_score;
//};
//
//struct Worker : virtual Person{
//    int m_salary;
//};
//
//struct Undergraduate : Student,Worker {
//    int m_grade;
//};

//-----------------------静态变量

//class Car {
//public:
//    static int m_price;
//    static void run() {
//        cout << "run()" << endl;
//    }
//};
////静态变量必须放在类外面初始化
//int Car::m_price = 0;

//////-----------------------单例模式
//class Rocket {
//private:
//    Rocket() {}
//    ~Rocket() {}
//    static Rocket *ms_rocket;
//    void operator=(const Rocket &recket) {}
//public:
//    static Rocket *sharedRocket() {
//        //这里要考虑多线程
//        if (ms_rocket == NULL) {
//            ms_rocket = new Rocket();
//        }
//        return ms_rocket;
//    }
//
//    static void deleteRocket() {
//        //这里要考虑多线程
//        if (ms_rocket != NULL) {
//            delete ms_rocket;
//            ms_rocket = NULL;
//        }
//    }
//};
//
//Rocket *Rocket::ms_rocket = NULL;

//-----------------------const成员
//class Car {
//public:
//    const int m_price = 0;
//    void run() const {
//        cout << "run()" << endl;
//    }
//};
//-----------------------引用类型成员
//class Car {
//    int age;
//    int &m_price = age;
//public:
//    Car(int &price) :m_price(price){}
//};
//-----------------------拷贝构造函数
//class Car {
//    int m_price;
//    int m_length;
//public:
//    Car(int price = 0,int length = 0) :m_price(price), m_length(length) {
//        cout << "Car(int price = 0,int length = 0)" << endl;
//    }
//    //拷贝构造
////    Car(const Car &car) {
////        cout << "Car(const Car &car)" << endl;
////        m_price = car.m_price;
////        m_length = car.m_length;
////    }
//
//    Car(const Car &car) :m_price(car.m_price),m_length(car.m_length) {
//        cout << "Car(const Car &car)" << endl;
//    }
//
//    void display() {
//        cout << "price=" << m_price << ",length=" << m_length << endl;
//    }
//};
//-----------------------调用父类的拷贝构造函数
//class Person {
//    int m_age;
//public:
//    Person(int age = 0) :m_age(age){}
//    Person(const Person &person) :m_age(person.m_age){};
//};
//
//class Student : public Person {
//    int m_score;
//public:
//    Student(int age = 0,int score = 0) :Person(age),m_score(score){}
//    Student(const Student &student) :Person(student),m_score(student.m_score){}
//};
//-----------------------编译器自动生成的构造函数
//class Person {
//public:
//    int m_age = 10;
//};
//
//class Person {
//public:
//    int m_age;
//    Person() {
//        m_age = 5;
//    }
//};
//-----------------------友元函数
//class Point {
//    friend Point add(Point, Point);
//    friend class Math;
//private:
//    int m_x;
//    int m_y;
//public:
//    int getX() { return m_x; };
//    int getY() { return m_y; };
//    Point(int x,int y) :m_x(x), m_y(y){}
//    void display() {
//        cout << "(" << m_x << ", " << m_y << ")" << endl;
//    }
//};
//
//Point add(Point p1, Point p2) {
//    return Point(p1.m_x + p2.m_x, p1.m_y + p2.m_y);
//}
//
//class Math {
//    Point add(Point p1, Point p2) {
//        return Point(p1.m_x + p2.m_x, p1.m_y + p2.m_y);
//    }
//};

//-----------------------内部类
//class Person {
//    int m_age;
//private:
//    class Car {
//        int m_price;
//
//        void run() {
//            Person person;
//            cout << person.m_age << endl;
//        }
//    };
//};

////-----------------------运算符重载
//class Point {
//    friend const Point operator+(const Point &, const Point &);
//    friend ostream &operator<<(ostream &, const Point &);
//    friend istream &operator>>(istream &cin, Point &point);
//    int m_x;
//    int m_y;
//public:
//    Point(int x,int y) :m_x(x), m_y(y){}
//    void display() {
//        cout << "(" << m_x << ", " << m_y << ")" << endl;
//    }
//    //定义成成员函数更好
//    const Point operator+(const Point &point) const {
//        return Point(m_x + point.m_x, m_y + point.m_y);
//    }
//
//    Point &operator+=(const Point &point) {
//        m_x += point.m_x;
//        m_y += point.m_y;
//        return *this;
//    }
//
//    bool operator==(const Point &point) const {
//        return (m_x == point.m_x) && (m_y == point.m_y);
//    }
//
//    const Point operator-() const {
//        return Point(-m_x,-m_y);
//    }
//
//    Point &operator++() {
//        m_x++;
//        m_y++;
//        return *this;
//    }
//
//    const Point operator++(int) {//代表后置
//        Point old(m_x,m_y);
//        m_x++;
//        m_y++;
//        return old;
//    }
//};
//
//const Point operator+(const Point &p1,const Point &p2) {
//    return Point(p1.m_x + p2.m_x, p1.m_y + p2.m_y);
//}
//
//ostream &operator<<(ostream &cout, const Point &point) {
//    cout << "(" << point.m_x << ", " << point.m_y << ")";
//    return cout;
//}
//
//istream &operator>>(istream &cin, Point &point) {
//    cin >> point.m_x;
//    cin >> point.m_y;
//    return cin;
//}


void test(int a,int b) {
    
}

// //-----------------------调用父类的运算符重载函数
class Person {
public:
    int m_age;
    Person &operator=(const Person &person) {
        m_age = person.m_age;
        return *this;
    }
};
//class Student : public Person {
//public:
//    int m_score;
//    Student &operator=(const Student &student) {
//        Person::operator=(student);
//        m_score = student.m_score;
//        return *this;
//    }
//};


//-----------------------仿函数
//class Sum {
//    int m_age;
//public:
//    int operator()(int a,int b) {
//        return a + b;
//    }
//};

//-----------------------模板
//template <typename T> T add(T a, T b) {
//    return a + b;
//}
//template <typename A,typename B> B add(A a, B b) {
//    return a + b;
//}
//
//template <typename Item>
//class Array {
//    Item *m_data;
//};

//-----------------------Lambda表达式


//int main(int argc, const char * argv[]) {
    
    
    
    //-----------------------异常
//    try {
//
//    } catch (...) {
//        throw 1;
//    }
//
//    try {
//
//    } catch (const char* ex) {
//        throw 1;
//    } catch (int a) {
//
//    }
    
    //-----------------------Lambda表达式
//    ([]{
//        cout << "haha" << endl;
//    }());
//
//    void (*p)() = []{
//        cout << "haha" << endl;
//    };
//    p();
//    auto pp = []{
//        cout << "hehe" << endl;
//    };
//    pp();
//
//    auto p1 = [](int a,int b)->int {
//        return a + b;
//    };
//    //返回值可省略
//    auto p2 = [](int a,int b) {
//        return a + b;
//    };
//    //捕获
//    int a = 1;
//    int b = 2;
//    auto p3 = [a,b]{
//        cout << a << "<" << b << endl;
//    };
//    p3();
    //-----------------------类型转换
//    const Person *p1 = new Person();
//    Person *p2 = const_cast<Person *>(p1);
//    Person *p3 = (Person *)p1;
//    printf("hahaha");
    //-----------------------模板
//    cout << add(10,20) << endl;
//    cout << add(1.1,2.2) << endl;
//    cout << add(1,2.2) << endl;
    
    //-----------------------仿函数
//    Sum sum;
//    cout << sum(10,20) << endl;
    
    
    //-----------------------单例模拟
//    Rocket *rocket = Rocket::sharedRocket();
    
    
    //-----------------------运算符重载
//    Point p1(10,20);
//    Point p2(20,30);
//    Point p3 = p1 + p2;
//    p3.display();
    
    
    //-----------------------调用父类的拷贝构造函数
//    Student s(20,98);
//    Student s1(s);
    
    //-----------------------拷贝构造函数
//    Car car1(100,5);
//    car1.display();
//    Car car2(car1);
//    car2.display();
    //-----------------------静态变量
//    Car car1;
//    car1.m_price = 100;
//
//    Car car2;
//    car2.m_price = 200;
//
//    Car::m_price = 300;
//
//    Car *p = new Car();
//    p->m_price = 400;
//    delete p;
    
    //-----------------------多态
//    Animal *animal = new Dog();
//    animal->speak();
    
    
//    Person1 person(18,180);
//    cout << person.m_age << endl;
    
//    int *p = new int;
//    int *p1 = new int();
//    int *p2 = new int(5);
//    int *p3 = new int[3]();
//    int *p4 = new int[3]{};
//    int *p5 = new int[3]{5};//首元素赋值为5
//
//    cout << *p << endl;
    
    
    
//    int *p = (int *)malloc(sizeof(int) * 10);
//    memset(p, 0, sizeof(int) * 10);
    
    
    
//    int *array = new int[4];
//    array[0] = 1;
//    array[2] = 2;
//    cout << array[2] << endl;
//    delete [] array;
    
    
//    int *zone = (int *)malloc(4);
//    *zone = 11;
//    cout << *zone << endl;
//    free(zone);
    
    
    
//    add(1, 2);
    
//    int age = 10;
//    int &refAge = age;
//    refAge = 21;
//    int age = 10;
//    int *p = &age;
//    int *&refp = p;
//    *refp = 100;
//
//    int height = 9;
//    refp = &height;
//    *refp = 66;
    
//    int array[] = {1, 2, 3};
//    int (&ref)[3] = array;
//
//    cout << ref[0] << endl;
    
//    cout << "hello world" << endl;
//    return 0;
//}
//默认参数

//函数重载

////输入输出
//cout << "hello world" << endl;
//int age;
//cin >> age;
//cout << "age is :" << age << endl;

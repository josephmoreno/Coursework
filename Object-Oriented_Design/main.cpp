#include <iostream>
#include <iomanip>
#include <fstream>
#include <sstream>
#include <string>
#include <ctime>
#include <vector>
#include <cstdlib>

using namespace std;

ifstream inFileStream;
ofstream outFileStream;
istringstream inStream;
ostringstream outStream;

vector<char> pwd_char(73); //Characters for the password.

int numberOfExams; //Number of exams present in scores.txt

class Pwdg {
public:
    void setPWD(int length){
        PWD = "";

        int x, rand_int;

        for(x = 0; x < length; ++x){
            rand_int = (rand() % 73);
            PWD = (PWD + pwd_char.at(rand_int));
        }
    };

    string getPWD(){
        return PWD;
    };

private:
    string PWD;

    int PWD_length;
};

class Strong_pwdg : public Pwdg {
public:
    string getStrongPWD(){
        strongPWD = "";

        //Global vector pwd_char replaced strong_char
        //strong_char.resize(73);

        //char temp_char;

        int /*temp_int = 0, random_int,*/ x;
        vector<int> pos(4);

        //Global vector for all the password characters; commented this out.
        /*for(temp_char = '0'; temp_char <= '9'; ++temp_char){
            strong_char.at(temp_int) = temp_char;
            ++temp_int;
        }

        for(temp_char = 'A'; temp_char <= 'Z'; ++temp_char){
            strong_char.at(temp_int) = temp_char;
            ++temp_int;
        }

        for(temp_char = 'a'; temp_char <= 'z'; ++temp_char){
            strong_char.at(temp_int) = temp_char;
            ++temp_int;
        }

        strong_char.at(temp_int) = '!';
        strong_char.at(++temp_int) = '@';
        strong_char.at(++temp_int) = '#';
        strong_char.at(++temp_int) = '$';
        strong_char.at(++temp_int) = '%';
        strong_char.at(++temp_int) = '^';
        strong_char.at(++temp_int) = '&';
        strong_char.at(++temp_int) = '*';
        strong_char.at(++temp_int) = '+';
        strong_char.at(++temp_int) = '-';
        strong_char.at(++temp_int) = '=';*/

        /*for(random_int = 0; random_int < 73; ++random_int){
            cout << strong_char.at(random_int) << endl;
        }*/

        //Global pwd_char vector replaced the strong_char vector
        mandatory_char.resize(4);
        mandatory_char.at(0) = pwd_char.at(rand() % 10);
        mandatory_char.at(1) = pwd_char.at((rand() % 26) + 10);
        mandatory_char.at(2) = pwd_char.at((rand() % 26) + 36);
        mandatory_char.at(3) = pwd_char.at((rand() % 11) + 62);

        cout << "Four mandatory random characters for your password: " << mandatory_char.at(0) << " "
             << mandatory_char.at(1) << " " << mandatory_char.at(2) << " " << mandatory_char.at(3) << endl;

        mandatory.resize(4);
        mandatory.at(0) = "";
        mandatory.at(1) = "";
        mandatory.at(2) = "";
        mandatory.at(3) = "";

        mandatory.at(0) = mandatory.at(0) + mandatory_char.at(0);
        mandatory.at(1) = mandatory.at(1) + mandatory_char.at(1);
        mandatory.at(2) = mandatory.at(2) + mandatory_char.at(2);
        mandatory.at(3) = mandatory.at(3) + mandatory_char.at(3);

        /*for(random_int = 0; random_int < 4; ++random_int){
            cout << mandatory.at(random_int) << endl;
        }*/

        //Creating the password.
        for(x = 0; x < strong_length; ++x){
            strongPWD = strongPWD + pwd_char.at(rand() % 73); //pwd_char replaced strong_char
            //cout << strongPWD << endl;
        }

        //Random 4 positions chosen from the created password.
        for(x = 0; x < 4; ++x){
            if (x == 0){
                pos.at(x) = (rand() % strong_length);
                strongPWD.replace(pos.at(x), 1, mandatory.at(x));
            }else {
                pos.at(x) = (rand() % strong_length);

                switch(x){
                    case 1: while(pos.at(x) == pos.at(0) || pos.at(x) == pos.at(2) || pos.at(x) == pos.at(3)){
                                pos.at(x) = (rand() % strong_length);
                            }
                            break;
                    case 2: while(pos.at(x) == pos.at(0) || pos.at(x) == pos.at(1) || pos.at(x) == pos.at(3)){
                                pos.at(x) = (rand() % strong_length);
                            }
                            break;
                    case 3: while(pos.at(x) == pos.at(0) || pos.at(x) == pos.at(1) || pos.at(x) == pos.at(2)){
                                pos.at(x) = (rand() % strong_length);
                            }
                }

                strongPWD.replace(pos.at(x), 1, mandatory.at(x));
            }
        }

        cout << "Your new password is: " << strongPWD << "\n" << endl;

        return strongPWD;
    };

    void setStrongLength(int strongLength){
        strong_length = strongLength;
    };

private:
    string strongPWD;
    vector<string> mandatory;

    //strong_char replaced by global vector pwd_char
    //vector<char> strong_char;
    vector<char> mandatory_char;

    int strong_length;
};

class Simple_pwdg : public Pwdg {
public:
    void setSimpleLength(int simpleLength){
        Pwd_length = simpleLength;
    }

    string setSimplePWD(char X){
        Pwd = "";

        char temp_char;

        int x = 0, rand_int;

        if (X == 'D'){
            Pwd_char.resize(10);

            for(temp_char = '0'; temp_char <= '9'; ++temp_char){
                Pwd_char.at(x) = temp_char;
                ++x;
            }

            for(x = 0; x < Pwd_length; ++x){
                rand_int = (rand() % 10);
                Pwd = (Pwd + Pwd_char.at(rand_int));
            }

            cout << Pwd << "\n" << endl;
        }else if (X == 'L'){
            Pwd_char.resize(52);

            for(temp_char = 'A'; temp_char <= 'Z'; ++temp_char){
                Pwd_char.at(x) = temp_char;
                ++x;
            }

            for(temp_char = 'a'; temp_char <= 'z'; ++temp_char){
                Pwd_char.at(x) = temp_char;
                ++x;
            }

            for(x = 0; x < Pwd_length; ++x){
                rand_int = (rand() % 52);
                Pwd = (Pwd + Pwd_char.at(rand_int));
            }

            cout << Pwd << "\n" << endl;
        }

        return Pwd;
    };

private:
    string Pwd;

    vector<char> Pwd_char;

    int Pwd_length;
};

void SetCharacters(){
    char temp_char;

    int temp_int = 0;

    for(temp_char = '0'; temp_char <= '9'; ++temp_char){
        pwd_char.at(temp_int) = temp_char;
        ++temp_int;
    }

    for(temp_char = 'A'; temp_char <= 'Z'; ++temp_char){
        pwd_char.at(temp_int) = temp_char;
        ++temp_int;
    }

    for(temp_char = 'a'; temp_char <= 'z'; ++temp_char){
        pwd_char.at(temp_int) = temp_char;
        ++temp_int;
    }

    pwd_char.at(temp_int) = '!';
    pwd_char.at(++temp_int) = '@';
    pwd_char.at(++temp_int) = '#';
    pwd_char.at(++temp_int) = '$';
    pwd_char.at(++temp_int) = '%';
    pwd_char.at(++temp_int) = '^';
    pwd_char.at(++temp_int) = '&';
    pwd_char.at(++temp_int) = '*';
    pwd_char.at(++temp_int) = '+';
    pwd_char.at(++temp_int) = '-';
    pwd_char.at(++temp_int) = '=';
};

vector<string> StoreInfo(int x){

    vector<string> info;
    string current_user = "", temp;

    int lines = 2, counter = 0;

    inFileStream.open("User\\passwords.txt");

    while(!inFileStream.eof()){
        if (lines != x){
            info.resize(counter + 1);
            getline(inFileStream, temp);
            info.at(counter) = temp;
            ++counter;

            /*inFileStream >> temp;
            info = info + temp + " ";

            inFileStream >> temp;
            info = info + temp + "\n";*/

            /*inFileStream.clear();
            inFileStream.ignore(10000, '\n');*/
        }else {
            getline(inFileStream, temp);
            current_user = current_user + temp;

            /*inFileStream >> temp;
            current_user = current_user + temp + " ";

            inFileStream >> temp;
            current_user = current_user + temp;*/

            /*inFileStream.clear();
            inFileStream.ignore(10000, '\n');*/
        }

        ++lines;
    }

    inFileStream.close();

    return info;

};

int Authenticate(int &x, string &y){

    string username, password, user_info = "", temp_string;

    x = 1;

    cout << "Enter your username: ";
    cin >> username;

    cin.clear();
    cin.ignore(10000, '\n');

    cout << "Enter your password: ";
    cin >> password;

    cin.clear();
    cin.ignore(10000, '\n');

    user_info = user_info + username + " " + password;

    inFileStream.open("User\\passwords.txt");

    while(!inFileStream.eof()){
        temp_string = "";

        inFileStream >> username;
        inFileStream >> password;

        temp_string = temp_string + username + " " + password;

        //Test to see inFileStream is grabbing the correct information.
        //cout << temp_string << endl;

        if (user_info == temp_string){
            cout << "User information accepted.\n" << endl;
            inFileStream.close();

            ++x;
            y = username; //Pass the accepted username.
            return 1; //Match found in the text file.
        }else {
            ++x;
        }
    }

    cout << "No matching user information.\n" << endl;
    inFileStream.close();
    return 0; //No match found in the text file.

};

void NewUser(){

    string username, file_username, temp_string = "";

    int pwd_length, x = 1; //x will be used to navigate passwords.txt

    cout << "Type out your new username (no spaces): ";
    cin >> username;
    cin.clear();
    cin.ignore(10000, '\n');

    //Open file to check if the username is taken.
    inFileStream.open("User\\passwords.txt");
    if (!inFileStream.is_open()){
        cout << "Could not open passwords.txt." << endl;
        return;
    }

    //Navigating the text file and searching for a matching username, which is not allowed.
    while(!inFileStream.eof()){
        if ((x % 2) == 1){
            inFileStream >> file_username;
            temp_string = temp_string + file_username + " "; //Storing the whole text file in a temporary string.

            if (inFileStream.good()){
                if (username == file_username){
                    cout << "Username already exists. Returning you to main menu.\n" << endl;
                    inFileStream.close();
                    return;
                }else {
                    ++x;
                }
            }
        }else {
            inFileStream >> file_username; //Get the next string to put in the buffer, then increment x.
            temp_string = temp_string + file_username + "\n";
            ++x;
        }
    }

    inFileStream.close();

    cout << "Enter the desired length of the password: ";
    cin >> pwd_length;

    cin.clear();
    cin.ignore(10000, '\n');

    Pwdg new_password;
    new_password.setPWD(pwd_length);

    cout << "Your new username is: " << username << endl
         << "Your new password is: " << new_password.getPWD() << "\n" << endl;

    //Open, write to the text file, and close.
    outFileStream.open("User\\passwords.txt");

    outFileStream << temp_string << username << " " << new_password.getPWD();

    outFileStream.close();

    return;

};

void ChangePwd(){

    vector<string> file_info;
    string username, temp_string = "";
    char choice;

    int pwd_length, lines, x = 0;
    int authenticate = Authenticate(lines, username);

    if (authenticate == 0){
        return;
    }else {
        cout << "Would you like to change your password? (Y/N): ";
        cin >> choice;

        cin.clear();
        cin.ignore(10000, '\n');

        switch(choice){
            case 'Y':
            case 'y': cout << "Enter the length you want your new password to be: ";
                      cin >> pwd_length;

                      cin.clear();
                      cin.ignore(10000, '\n');

                      cout << "Would you like a strong password? (Y/N): ";
                      cin >> choice;

                      cin.clear();
                      cin.ignore(10000, '\n');

                      if (choice == 'Y' || choice == 'y'){
                            Strong_pwdg strongPassword;

                            if (pwd_length < 8) {
                                pwd_length = 8;
                                cout << "Password length changed to 8 characters." << endl;
                            }

                            strongPassword.setStrongLength(pwd_length);
                            temp_string = temp_string + username + " " + strongPassword.getStrongPWD();
                      }else if (choice == 'N' || choice == 'n'){
                            cout << "Would you like a password with only digits (D), only letters (L), or a normal password? "
                                 << "(D/L/N): ";
                            cin >> choice;

                            cin.clear();
                            cin.ignore(10000, '\n');

                            switch(choice){
                                case 'D':
                                case 'd': {
                                          Simple_pwdg simplePasswordD;

                                          //simplePassword.setDigits();

                                          simplePasswordD.setSimpleLength(pwd_length);

                                          cout << "Your new password is: ";
                                          temp_string = temp_string + username + " " + simplePasswordD.setSimplePWD('D');
                                          }
                                          break;
                                case 'L':
                                case 'l': {
                                          Simple_pwdg simplePasswordL;

                                          simplePasswordL.setSimpleLength(pwd_length);

                                          cout << "Your new password is: ";
                                          temp_string = temp_string + username + " " + simplePasswordL.setSimplePWD('L');
                                          }
                                          break;
                                case 'N':
                                case 'n': {
                                          Pwdg newPassword;

                                          //newPassword.setCharacters();

                                          newPassword.setPWD(pwd_length);
                                          cout << "Your new password is: " << newPassword.getPWD() << "\n" << endl;
                                          temp_string = temp_string + username + " " + newPassword.getPWD();
                                          }
                                          break;
                                default: cout << "Invalid choice. Returning you to main menu.\n" << endl;
					 return;
                            }
                      }else {
			   cout << "Invalid choice. Returning you to the main menu.\n" << endl;
			   return;
		      }

                      break;
            case 'N':
            case 'n': cout << "Returning you to the main menu.\n" << endl;
                      return;
            default: cout << "Invalid choice. Returning you to the main menu.\n" << endl;
		     return;
        }
    }

    file_info = StoreInfo(lines);

    outFileStream.open("User\\passwords.txt");

    for(x = 0; x < file_info.size(); ++x){
        outFileStream << file_info.at(x) << endl;
    }

    outFileStream << temp_string;

    outFileStream.close();

    return;

};

void StoreScores(vector< vector<int> > &exam_scores, vector<string> &IDs){

    string username, ID;

    int /*lines, score1, score2, score3, score4,*/ counter = 0, x;
    /*int authenticate = Authenticate(lines, username);

    if (authenticate == 0){
        return;
    }else {*/
        inFileStream.open("Data\\numberOfExams.txt"); //Stored the number of exams in a text file.
        inFileStream >> numberOfExams;
        inFileStream.close();

        inFileStream.open("Data\\scores.txt");

        //cout << "=== Students' Exam Scores ===" << endl;
        while(!inFileStream.eof()){
            inFileStream >> ID;
            IDs.resize(counter + 1);
            IDs.at(counter) = ID;

            /*inFileStream >> score1;
            inFileStream >> score2;
            inFileStream >> score3;
            inFileStream >> score4;*/

            exam_scores.resize(counter + 1);
            exam_scores[counter].resize(numberOfExams);
            for(x = 0; x < exam_scores[counter].size(); ++x){
                inFileStream >> exam_scores[counter][x];
            }

            /*exam_scores[counter].at(0) = score1;
            exam_scores[counter].at(1) = score2;
            exam_scores[counter].at(2) = score3;
            exam_scores[counter].at(3) = score4;*/

            ++counter;

            /*cout << "ID: " << ID << "\tExam Scores (1-4): " << score1 << ", " << score2 << ", " << score3 << ", "
                 << score4 << endl << endl;*/
        }

        inFileStream.close();
    //}

    //See if the vectors are getting the correct data.
    /*int tempx, tempy;

    cout << "\n\nTEST TEST TEST" << endl;

    for(tempx = 0; tempx < exam_scores.size(); ++tempx){
        for(tempy = 0; tempy < exam_scores[tempx].size(); ++tempy){
            cout << exam_scores[tempx][tempy] << " ";
        }

        cout << endl;
    }

    for(tempx = 0; tempx < IDs.size(); ++tempx){
        cout << IDs[tempx] << endl;
    }

    cout << "TEST TEST TEST\n" << endl;*/

    return;

};

void DisplayScore(/*vector< vector<int> > &exam_scores, vector<string> &IDs*/){

    vector< vector<int> > exam_scores;
    vector<string> IDs;

    string username, ID;

    int lines, counter = 0, y, found;
    int authenticate = Authenticate(lines, username);

    if (authenticate == 0){
        return;
    }else {
        cout << "Enter the ID of the student whose scores you want to view (ID format: U###): ";
        cin >> ID;

        cin.clear();
        cin.ignore(10000, '\n');

        StoreScores(exam_scores, IDs);

        for(counter = 0; counter < IDs.size(); ++counter){
            if (IDs.at(counter) == ID){
                cout << "Matching student ID found." << endl;

                for(y = 0; y < exam_scores[counter].size(); ++y){
                    cout << "Exam " << (y + 1) << ": " << exam_scores[counter][y] << endl;
                }

                cout << endl;

                found = 1;
                break;
            }else {
                found = 0;
            }
        }

        if (found == 0){
            cout << "No matching student ID found with the query. Returning to the main menu.\n" << endl;
        }
    }

    //See if the vectors are getting the correct data.
    /*int tempx, tempy;

    cout << "\n\nTEST TEST TEST" << endl;

    for(tempx = 0; tempx < exam_scores.size(); ++tempx){
        for(tempy = 0; tempy < exam_scores[tempx].size(); ++tempy){
            cout << exam_scores[tempx][tempy] << " ";
        }

        cout << endl;
    }

    for(tempx = 0; tempx < IDs.size(); ++tempx){
        cout << IDs[tempx] << endl;
    }

    cout << "TEST TEST TEST\n" << endl;*/

    return;

};

void ExamScore(){

    vector< vector<int> > exam_scores;
    vector<string> IDs;

    string username;

    int lines, exam, counter = 0;
    int authenticate = Authenticate(lines, username);

    if (authenticate == 0){
        return;
    }else {
        StoreScores(exam_scores, IDs);

        cout << "Enter which exam you want to the scores of (1-" << numberOfExams << "): ";
        cin >> exam;

        cin.clear();
        cin.ignore(10000, '\n');

        if ((exam < 1) || (exam > numberOfExams)){
            cout << "Invalid input. Returning to the main menu.\n" << endl;
            return;
        }

        cout << "=== Exam " << exam << " Scores ===" << endl;
        for(counter = 0; counter < exam_scores.size(); ++counter){
            cout << exam_scores[counter][exam - 1] << endl;
        }

        cout << endl;

    }

    return;

};

void StudentAverage(){

    vector< vector<int> > exam_scores;
    vector<string> IDs;

    string username, ID;

    int lines, counter = 0, x, found;
    int authenticate = Authenticate(lines, username);

    double average, sum = 0;

    if (authenticate == 0){
        return;
    }else {
        cout << "Enter the ID of the student whose average you want to calculate (ID format: U###): ";
        cin >> ID;

        cin.clear();
        cin.ignore(10000, '\n');

        StoreScores(exam_scores, IDs);

        for(counter = 0; counter < IDs.size(); ++counter){
            if (IDs.at(counter) == ID){
                cout << "Matching student ID found." << endl;
                found = 1;

                for(x = 0; x < exam_scores[counter].size(); ++x){
                    sum += exam_scores[counter][x];
                }

                average = (sum / exam_scores[counter].size());

                cout << ID << "'s average over " << numberOfExams << " exams: " << setprecision(4) << average << endl;

                break;
            }else {
                found = 0;
            }
        }

        if (found == 0){
            cout << "No matching student ID found with the query. Returning to the main menu.\n" << endl;
            return;
        }

        cout << endl;
    }

    return;

};

void ExamAverage(){

    vector< vector<int> > exam_scores;
    vector<string> IDs;

    string username;

    int lines, counter = 0, exam;
    int authenticate = Authenticate(lines, username);

    double average, sum = 0;

    if (authenticate == 0){
        return;
    }else {
        StoreScores(exam_scores, IDs);

        cout << "Enter the exam whose average you want to see (1-" << numberOfExams << "): ";
        cin >> exam;

        cin.clear();
        cin.ignore(10000, '\n');

        if ((exam < 1) || (exam > numberOfExams)){
            cout << "Invalid input. Returning to the main menu.\n" << endl;
            return;
        }

        for(counter = 0; counter < exam_scores.size(); ++counter){
            sum += exam_scores[counter][exam - 1];
        }

        average = (sum / exam_scores.size());

        cout << "Exam " << exam << "'s average: " << setprecision(4) << average;
        cout << endl << endl;
    }

    return;

};

void InsertExam(){

    vector< vector<int> > exam_scores;
    vector<string> IDs;

    string username;

    char choice;

    int lines, counter = 0, x, y;
    int authenticate = Authenticate(lines, username);

    if (authenticate == 0){
        return;
    }else {
        cout << "Would you like to insert a new exam for all students? (Y/N): ";
        cin >> choice;

        cin.clear();
        cin.ignore(10000, '\n');

        switch(choice){
            case 'Y':
            case 'y': StoreScores(exam_scores, IDs);

                      ++numberOfExams;

                      outFileStream.open("Data\\numberOfExams.txt");
                      outFileStream << numberOfExams; //Store the new number of exams in the text file.
                      outFileStream.close();

                      for(counter = 0; counter < exam_scores.size(); ++counter){
                            exam_scores[counter].resize(numberOfExams);

                            cout << "Enter the score of exam " << numberOfExams << " for student "
                                 << IDs.at(counter) << ": ";
                            cin >> exam_scores[counter][numberOfExams - 1];

                            cin.clear();
                            cin.ignore(10000, '\n');

                            if ((exam_scores[counter][numberOfExams - 1] < 0) || (exam_scores[counter][numberOfExams - 1] > 100)){
                                cout << "Invalid score entered. Setting the score to 0.\n" << endl;
                                exam_scores[counter][numberOfExams - 1] = 0;
                            }
                      }
                      break;
            case 'N':
            case 'n': cout << "Returning to main menu.\n" << endl;
                      return;
            default: cout << "Invalid option. Returning to the main menu.\n" << endl;
                     return;
        }

        outFileStream.open("Data\\scores.txt");

        for(x = 0; x < IDs.size(); ++x){
            outFileStream << IDs.at(x) << " ";

            for(y = 0; y < exam_scores[x].size(); ++y){
                if (y != (exam_scores[x].size() - 1)){ //Scores before the last score of a line.
                    outFileStream << exam_scores[x][y] << " ";
                }else if ((y == (exam_scores[x].size() - 1)) && (x != (IDs.size() - 1))){ //Last exam score for a student.
                    outFileStream << exam_scores[x][y] << endl;
                }else if ((y == (exam_scores[x].size() - 1)) && (x == (IDs.size() - 1))){ //Very last score in the file.
                    outFileStream << exam_scores[x][y];
                }
            }
        }

        outFileStream.close();

        cout << "New exam with scores added.\n" << endl;
    }

    return;

};

void InsertStudent(){

    vector< vector<int> > exam_scores;
    vector<string> IDs;

    string username, ID_string;

    char choice;

    int lines, counter = 0, ID_num, x, y;
    int authenticate = Authenticate(lines, username);

    if (authenticate == 0){
        return;
    }else{
        cout << "Would you like to insert a new student with all their exam scores? (Y/N): ";
        cin >> choice;

        cin.clear();
        cin.ignore(10000, '\n');

        switch(choice){
            case 'Y':
            case 'y': StoreScores(exam_scores, IDs);
                      IDs.resize(IDs.size() + 1);
                      exam_scores.resize(exam_scores.size() + 1);
                      exam_scores[exam_scores.size() - 1].resize(numberOfExams);

                      IDs.at(IDs.size() - 1) = "";

                      cout << "Enter the three numbers in the new student's ID (without the U): ";
                      cin >> ID_num;

                      cin.clear();
                      cin.ignore(10000, '\n');

                      outStream << ID_num;
                      ID_string = outStream.str();

                      outStream.str(string());

                      if((ID_num > 999) || (ID_num < 0)){ //Invalid input; negative numbers or more than three digits.
                            cout << "Invalid input. Returning to the main menu.\n" << endl;
                            return;
                      }else if ((ID_num >= 0) && (ID_num <= 9)){ //Single digit numbers.
                            IDs.at(IDs.size() - 1) += "U00" + ID_string;
                      }else if ((ID_num >= 10) && (ID_num <= 99)){ //Double digit numbers
                            IDs.at(IDs.size() - 1) += "U0" + ID_string;
                      }else if ((ID_num >= 100) && (ID_num <= 999)){
                            IDs.at(IDs.size() - 1) += "U" + ID_string;
                      }else {
                            cout << "Invalid input. Returning to the main menu.\n" << endl;
                            return;
                      }

                      for(counter = 0; counter < (IDs.size() - 1); ++counter){
                            if (IDs.at(counter) == IDs.at(IDs.size() - 1)){
                                cout << "A student with this ID already exists. Returning to the main menu.\n" << endl;
                                return;
                            }
                      }

                      //Test to see if ID is being picked up correctly.
                      /*cout << "\n\nTEST TEST TEST" << endl;
                      cout << IDs.at(IDs.size() - 1) << endl;
                      cout << "TEST TEST TEST\n" << endl;*/

                      for(counter = 0; counter < exam_scores[exam_scores.size() - 1].size(); ++counter){
                            cout << "Enter student " << ID_num << "'s score for exam " << counter + 1 << ": ";
                            cin >> exam_scores[exam_scores.size() - 1][counter];

                            cin.clear();
                            cin.ignore(10000, '\n');

                            if ((exam_scores[exam_scores.size() - 1][counter] < 0) || exam_scores[exam_scores.size() - 1][counter] > 100){
                                cout << "Invalid score entered. Setting score to 0.\n" << endl;
                                exam_scores[exam_scores.size() - 1][counter] = 0;
                            }
                      }

                      //Write new information to scores.txt
                      outFileStream.open("Data\\scores.txt");
                      for(x = 0; x < IDs.size(); ++x){
                            outFileStream << IDs.at(x) << " ";

                            for(y = 0; y < exam_scores[x].size(); ++y){
                                if (y != (exam_scores[x].size() - 1)){
                                    outFileStream << exam_scores[x][y] << " ";
                                }else if ((y == (exam_scores[x].size() - 1)) && (x != (exam_scores.size() - 1))){
                                    outFileStream << exam_scores[x][y] << endl;
                                }else if ((y == (exam_scores[x].size() - 1)) && (x == (exam_scores.size() - 1))){
                                    outFileStream << exam_scores[x][y];
                                }
                            }
                      }

                      outFileStream.close();

                      cout << "Student ID and exam scores added.\n" << endl;

                      break;
            case 'N':
            case 'n': cout << "Returning to the main menu.\n" << endl;
                      return;
            default: cout << "Invalid option. Returning to the main menu.\n" << endl;
                     return;
        }
    }

    return;

};

void ScoreUpdate(){

    vector< vector<int> > exam_scores;
    vector<string> IDs;

    string username, ID;

    int lines, counter = 0, exam, found, x, y;
    int authenticate = Authenticate(lines, username);

    if (authenticate == 0){
        return;
    }else {
        StoreScores(exam_scores, IDs);

        cout << "Enter the ID of the student whose records you want to edit (ID format: U###): ";
        cin >> ID;

        cin.clear();
        cin.ignore(10000, '\n');

        for(counter = 0; counter < IDs.size(); ++counter){
            if (IDs.at(counter) == ID){
                cout << "Matching student ID found." << endl;
                found = 1;

                cout << "Which exam score do you want to alter? (1-" << numberOfExams << "): ";
                cin >> exam;

                cin.clear();
                cin.ignore(10000, '\n');

                if ((exam < 1) || (exam > numberOfExams)){
                    cout << "Invalid input. Returning to the main menu.\n" << endl;
                    return;
                }

                cout << "Enter the new score to be entered for student " << ID << "'s exam " << exam << ": ";
                cin >> exam_scores[counter][exam - 1];

                cin.clear();
                cin.ignore(10000, '\n');

                if ((exam_scores[counter][exam - 1] < 0) || (exam_scores[counter][exam - 1] > 100)){
                    cout << "Invalid score. Setting score to 0." << endl;
                    exam_scores[counter][exam - 1] = 0;
                }

                outFileStream.open("Data\\scores.txt");

                for(x = 0; x < IDs.size(); ++x){
                            outFileStream << IDs.at(x) << " ";

                            for(y = 0; y < exam_scores[x].size(); ++y){
                                if (y != (exam_scores[x].size() - 1)){
                                    outFileStream << exam_scores[x][y] << " ";
                                }else if ((y == (exam_scores[x].size() - 1)) && (x != (exam_scores.size() - 1))){
                                    outFileStream << exam_scores[x][y] << endl;
                                }else if ((y == (exam_scores[x].size() - 1)) && (x == (exam_scores.size() - 1))){
                                    outFileStream << exam_scores[x][y];
                                }
                            }
                      }

                outFileStream.close();

                cout << "Student's exam score has been updated.\n" << endl;

                break;
            }else {
                found = 0;
            }
        }

        if (found == 0){
            cout << "No matching student ID found. Returning to the main menu.\n" << endl;
            return;
        }
    }

    return;

};

void ExamUpdate(){

    vector< vector<int> > exam_scores;
    vector<string> IDs;

    string username;

    int lines, counter = 0, points, exam, x, y;
    int authenticate = Authenticate(lines, username);

    if (authenticate == 0){
        return;
    }else{
        StoreScores(exam_scores, IDs);

        cout << "Enter which exam whose scores you want to alter (1-" << numberOfExams << "): ";
        cin >> exam;

        cin.clear();
        cin.ignore(10000, '\n');

        if ((exam < 1) || (exam > numberOfExams)){
            cout << "Invalid exam number. Returning to the main menu.\n" << endl;
            return;
        }

        cout << "Enter how many points you want to add or subtract (-100 to 100): ";
        cin >> points;

        cin.clear();
        cin.ignore(10000, '\n');

        if ((points < -100) || (points > 100)){
            cout << "Invalid amount of points. Returning to the main menu.\n" << endl;
            return;
        }

        for(counter = 0; counter < exam_scores.size(); ++counter){
            exam_scores[counter][exam - 1] += points;

            if (exam_scores[counter][exam - 1] < 0){
                exam_scores[counter][exam - 1] = 0;
            }else if (exam_scores[counter][exam - 1] > 100){
                exam_scores[counter][exam - 1] = 100;
            }
        }

        outFileStream.open("Data\\scores.txt");

        for(x = 0; x < IDs.size(); ++x){
            outFileStream << IDs.at(x) << " ";

            for(y = 0; y < exam_scores[x].size(); ++y){
                if (y != (exam_scores[x].size() - 1)){
                    outFileStream << exam_scores[x][y] << " ";
                }else if ((y == (exam_scores[x].size() - 1)) && (x != (exam_scores.size() - 1))){
                    outFileStream << exam_scores[x][y] << endl;
                }else if ((y == (exam_scores[x].size() - 1)) && (x == (exam_scores.size() - 1))){
                    outFileStream << exam_scores[x][y];
                }
            }
        }

        outFileStream.close();

        cout << "Exam " << exam << "'s scores updated for all students.\n" << endl;
    }

    return;

}

int main()
{

    int options = 0;

    srand(time(0));

    SetCharacters();

    cout << endl;

    while(options != 11){
        cout << "(1)  Create a new user\n"
             << "(2)  Change password\n"
             << "(3)  Display scores of a student\n"
             << "(4)  Display scores of an exam\n"
             << "(5)  Display the average score of a student\n"
             << "(6)  Display the average score of an exam\n"
             << "(7)  Insert scores of a new exam to all students\n"
             << "(8)  Insert scores of all exams of a student who is not on file\n"
             << "(9)  Update an exam score of a student\n"
             << "(10) Update every student's exam score\n"
             << "(11) Exit\n" << endl;

        cout << "Choose an option (1 to 11): ";
        cin >> options;

        cin.clear();
        cin.ignore(10000, '\n');

        switch(options){
            case 1: NewUser();
                    break;
            case 2: ChangePwd();
                    break;
            case 3: DisplayScore();
                    break;
            case 4: ExamScore();
                    break;
            case 5: StudentAverage();
                    break;
            case 6: ExamAverage();
                    break;
            case 7: InsertExam();
                    break;
            case 8: InsertStudent();
                    break;
            case 9: ScoreUpdate();
                    break;
            case 10: ExamUpdate();
                     break;
            case 11: cout << "Goodbye." << endl;
                     break;
            default: cout << "Invalid option.\n" << endl;
                     break;
        }
    }

    return 0;

}

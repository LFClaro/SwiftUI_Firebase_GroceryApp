//
//  ContentView.swift
//  LuizClaro_N01459385_A2
//
//  Created by Luiz Claro on 2022-04-15.
//

import SwiftUI
import Firebase

struct ContentView: View {
    //MARK: - Login variables
    @State var email : String = ""
    @State var password : String = ""
    
    //MARK: - Alert event variables
    @State var screenOpacity : CGFloat = 1.0
    @State var isLoading : Bool = false
    @State var isScreenDisabled : Bool = false
    @State var isAlertPresented : Bool = false
    @State var alertMsg : String = ""
    
    //MARK: - Sign up variables
    @State var showSignUpAlert: Bool = false
    @State var textStringEmail: String = ""
    @State var textStringPassword: String = ""
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                //MARK: - Once the user is signed up, we can see a list of already signed up users
            }
        }
    }
    
    var body: some View {
        ZStack{
            Color("bg").ignoresSafeArea()
            VStack{
                Spacer()
                Text("Luiz's Grocr").font(.custom("Avenir-Light", size: sf.h * 0.07))
                Spacer()
                Spacer()

                Group{
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(UITextContentType.emailAddress)
                        .keyboardType(UIKeyboardType.emailAddress)
                        .foregroundColor(Color.primary)
                        .padding(8)
                        .background()
                        .cornerRadius(5)
                    SecureField("Password", text: $password)
                        .textContentType(UITextContentType.password)
                        .foregroundColor(Color.primary)
                        .padding(8)
                        .background()
                        .cornerRadius(5)
                        .padding(.bottom)

                    CustomButtonView(text: "Login", action: {
                        withAnimation {
                            isLoading = true

                            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                                if let error = error, user == nil {
                                    //MARK: - If signed in failed, create an alert
                                    alertMsg = error.localizedDescription
                                    isAlertPresented.toggle()
                                }

                                isLoading = false
                            }
                        }
                    })
                    .padding(.bottom)

                    Button {
                        self.textStringEmail = ""
                        self.textStringPassword = ""
                        self.showSignUpAlert = true
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(.black, lineWidth: 1)
                            .overlay {
                                Text("Sign Up").font(.custom("Avenir-Light", size: sf.h * 0.025))
                                    .cornerRadius(5)
                            }.frame(maxHeight: sf.h * 0.04)
                    }
                    .padding(.bottom, 5)
//                    .onChange(of: textStringEmail) { newValue in
//                        print("\(textStringEmail)\n \(textStringPassword)")
//    //                    Task {
//                            Auth.auth().createUser(withEmail: textStringEmail, password: textStringPassword) { user, error in
//                                //MARK: - If there is no error, perform a signIn using the Auth library signIn function
//                                if error == nil {
//                                    Auth.auth().signIn(withEmail: textStringEmail, password: textStringPassword)
//                                    print("USER ====> \(String(describing: user))")
//                                } else {
//                                    print("FIREBASE ERROR HERE ====> \(String(describing: error))")
//                                }
//                            }
//    //                    }
//                    }

                    Button {
                        //TODO
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(.black, lineWidth: 1)
                            .overlay {
                                Text("Upload Images").font(.custom("Avenir-Light", size: sf.h * 0.025))
                                    .cornerRadius(5)
                            }.frame(maxHeight: sf.h * 0.04)
                    }

                }.frame(maxWidth: sf.w * 0.65, alignment: .center)

                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            if self.showSignUpAlert {
                AlertControlView(textStringEmail: $textStringEmail, textStringPassword: $textStringPassword,
                                 showAlert: $showSignUpAlert,
                                 title: "Sign Up",
                                 message: "Please fill out the fields.")
            }
        }
        .disabled(isScreenDisabled)
        .opacity(screenOpacity)
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text("ERROR"), message: Text(alertMsg), dismissButton: Alert.Button.default(Text("OK")))
        }
        .overlay {
            if isLoading {
                withAnimation {
                    LoadingView()
                        .onAppear {
                            screenOpacity = 0.5
                            isScreenDisabled = true
                        }
                        .onDisappear {
                            screenOpacity = 1
                            isScreenDisabled = false
                        }
                }
            }
        }

//        NavigationView {
//            ZStack {
//                Color("bg").ignoresSafeArea()
//                VStack {
//                    Text(self.textStringEmail)
//                    Text(self.textStringPassword)
//                        .onChange(of: textStringEmail) { newValue in
//                            print("\(textStringEmail)\n \(textStringPassword)")
//                            Task {
//                                Auth.auth().createUser(withEmail: textStringEmail, password: textStringPassword) { user, error in
//                                    //MARK: - If there is no error, perform a signIn using the Auth library signIn function
//                                    if error == nil {
//                                        Auth.auth().signIn(withEmail: textStringEmail, password: textStringPassword)
//                                        print("USER ====> \(String(describing: user))")
//                                    } else {
//                                        print("FIREBASE ERROR HERE ====> \(String(describing: error))")
//                                    }
//                                }
//                            }
//                        }
//                }
//
//
//            }
//
//            .navigationBarTitle("UIAlertController ", displayMode: .inline)
//            .navigationBarItems(
//                trailing:
//                VStack {
//                    Button(action: {
//                        self.textStringEmail = ""
//                        self.textStringPassword = ""
//                        self.showAlert = true
//                    })
//                    {
//                        Text("Show")
//                    }
//            })
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().foregroundColor(.white)
    }
}

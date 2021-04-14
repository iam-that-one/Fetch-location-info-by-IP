//
//  ContentView.swift
//  Find-location-by-IP
//
//  Created by Abdullah Alnutayfi on 13/04/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = LocationViewModel()
    @State var ip = ""
    var body: some View {
        VStack{
            HStack{
            TextField("id", text: $ip)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                vm.fetch_location(ip: ip)
            }, label: {
                Image(systemName: "magnifyingglass")
                    
                    .padding(8)
                    .background(Color.yellow)
                    .shadow(color:.black,radius: 10)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold, design: .default))
            })
            }
            ScrollView{
                HStack{
                VStack(alignment: .leading){
            ForEach(vm.locations){location in
                VStack(alignment: .leading){
                HStack{
                Text("\(location.countryName ?? "")")
                    .font(.title)
                Image(uiImage:UIImage(data: vm.loadImage(ImageUrl: location.countryFlag ?? "") ?? Data()) ?? UIImage())
                    .resizable()
                    .frame(width: 60, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                    Group{
                        Text("IP: \(location.ip ?? "")")
                        Text("country Code: \(location.countryCode2 ?? "")")
                        Text("city: \(location.city ?? "NO Value")")
                        Text("calling code: \(location.callingCode ?? "NO Value")")
                        Text("latitude: \(location.latitude ?? "NO Value")")
                        Text("longitude: \(location.longitude ?? "NO Value")")
                        Text("languages: \(location.languages ?? "NO Value")")
                        Text("country capital: \(location.countryCapital ?? "NO Value")")
                        Text("languages: \(location.languages ?? "NO Value")")
                            }
                    Group{
                        Text("State/Province: \(location.stateProv ?? "NO Value")")
                        Text("District/County: \(location.district ?? "NO Value")")
                        Text("Zip Code: \(location.zipcode ?? "NO Value")")
                        Text("Geoname ID: \(location.geonameID ?? "NO Value")")
                        Text("ISP: \(location.isp ?? "NO Value")")
                        Text("Connection Type: \(location.connectionType ?? "NO Value")")
                        Text("Organization: \(location.organization ?? "NO Value")")
                        Text("AS Number: \(location.asn ?? "NO Value")")
                        Text("Currency: \(location.currency?.name ?? "NO Value"), Symbol:  \(location.currency?.symbol ?? "")")
                        Text("Currency Code: \(location.currency?.code ?? "NO Value")")
                        }
                    Group{
                        Text("Timezone: \(location.timeZone?.name ?? "NO Value")")
                        Text("Current Time: \(location.timeZone?.currentTime ?? "NO Value")")
                        Text("Timezone: \(location.timeZone?.currentTimeUnix ?? 0.0)")
                        }
                    
            }
            }
            }
                Spacer()
            }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ProgressCircle.swift
//  Tasker
//
//  Created by Arthur Ford on 10/26/21.
//

import SwiftUI

struct ProgressCircle: View {
    var state: ProgressState = ProgressState.onTrack
    var progress: Int = 0

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .frame(width: 72, height: 72)
            switch state {
                case ProgressState.onTrack:
                    Circle()
                        .trim(from: CGFloat(1 - Double(progress) / 100), to: 1)
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .frame(width: 72, height: 72)
                        .shadow(color: .green.opacity(0.4), radius: 3, x: 0, y: 3)
                case ProgressState.atRisk:
                    Circle()
                        .trim(from: CGFloat(1 - Double(progress) / 100), to: 1)
                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .frame(width: 72, height: 72)
                        .shadow(color: .yellow.opacity(0.4), radius: 3, x: 0, y: 3)
                case ProgressState.offTrack:
                    Circle()
                        .trim(from: CGFloat(1 - Double(progress) / 100), to: 1)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .frame(width: 72, height: 72)
                        .shadow(color: .red.opacity(0.4), radius: 3, x: 0, y: 3)
                case ProgressState.notStarted:
                    Circle()
                        .trim(from: CGFloat(1 - Double(progress) / 100), to: 1)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .frame(width: 72, height: 72)
                        .shadow(color: .gray.opacity(0.4), radius: 3, x: 0, y: 3)
                case ProgressState.completed:
                    Circle()
                        .trim(from: CGFloat(1 - Double(progress) / 100), to: 1)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .frame(width: 72, height: 72)
                        .shadow(color: .blue.opacity(0.4), radius: 3, x: 0, y: 3)
            }
            Text("\(progress)%")
                .font(.headline)
                .fontWeight(.bold)
        }
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle()
    }
}

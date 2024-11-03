using EpistemicNetworkAnalysis
using CSV
using DataFrames

#Add GLM to be able to do linear models.
using GLM

data = DataFrame(CSV.File("C:\\Users\\jscianna\\Documents\\GitHub\\ICQE-Rotations-Workshop-2024\\Data\\CodedPilot.csv"))

codes = [:Retry, :Challenge, :ResourceUse, :Break, :GoodMove, :SeekingFeedback, :LevelComplete]
conversations = [:Username, :SessionNum]
units = [:Username]
rotation = FormulaRotation(
    LinearModel, @formula(edge ~ 1 + SpatialReasoningScore), 2, nothing
)

model = ENAModel(
    data, codes, conversations, units,
    windowSize=10,
    rotateBy=rotation,
    dropEmpty=true,
)

show(model)
p = plot(model)

using Plots 
savefig(p,"MClassRotation.png")

#Saving the point positions to CSV
using CSV
CSV.write("MClassPoints.csv",model.points)
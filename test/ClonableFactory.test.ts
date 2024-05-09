import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { getContractAddress } from "@openzeppelin/hardhat-upgrades/dist/utils";
import { expect } from "chai";
import { ethers, upgrades } from "hardhat";
import contractArtifact from "../artifacts/contracts/Template.sol/Template.json"

describe("ClonableFactory", function() {
  async function deploy() {
    const [deployer, user2] = await ethers.getSigners();

    const Template = await ethers.getContractFactory("Template");
    const template = await Template.deploy();
    await template.waitForDeployment();

    const CloneFactory = await ethers.getContractFactory("CloneFactory");
    const cloneFactory = await CloneFactory.deploy();
    await cloneFactory.waitForDeployment();

    return { template, deployer, user2, cloneFactory }
  }

  it("Cloned address should be proper address", async function() {
    const { cloneFactory, template } = await loadFixture(deploy);
    // cloning a contract and obtaining its address 
    const tx = await cloneFactory.createClone(template.target);
    const receipt: any = await tx.wait(); 
    const cloneAddress = receipt?.logs[0].args[1] as string

    // checking that the address is correct
    expect(cloneAddress).to.be.properAddress;

    // checking that the address is not equal to the template address
    expect(cloneAddress).to.not.equal(template.target);

    // create a contract instance from the address
    const clonedContract = await ethers.getContractAt("Template", cloneAddress);
    
    // checking default value of x
    expect(await clonedContract.x()).to.equal(0);

    // setting x to 1 and checking if it is set
    await clonedContract.setX(1);
    expect(await clonedContract.x()).to.equal(1);

    // x in template should still be 0
    expect(await template.x()).to.equal(0);
  });
});
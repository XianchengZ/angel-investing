import { assert } from 'chai'
import { ethers } from 'hardhat'
import { Campaign, Campaign__factory } from '../typechain-types'

describe('Campaign', function () {
  let CampaignFactory: Campaign__factory
  let Campaign: Campaign
  beforeEach(async () => {
    CampaignFactory = await ethers.getContractFactory('Campaign')
    Campaign = await CampaignFactory.deploy('50')
  })

  it('deploy successfully', async () => {
    const [owner, addr1, addr2] = await ethers.getSigners()
    // console.log(owner.address, addr1.address, addr2.address)
    const manager = await Campaign.manager()

    console.log(manager)
  })

  it('requires minimum contribution', async () => {
    try {
      const minCon = await Campaign.minimumContribution()
      console.log(minCon)
      await Campaign.contribute({
        value: ethers.utils.parseUnits('30', 'wei'),
      })
      assert.fail('Transaction should not go through')
    } catch (error) {
      assert.ok('catched error')
    }
  })
})
